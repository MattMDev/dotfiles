#!/usr/bin/env bash 
set -x

LOG_FILE="/tmp/monitor_toggle.log"
# rm -f "$LOG_FILE" | true

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

tv="HDMI-A-3"
main_screen="DP-1"
secondary_screen="DP-3"

log "Script started - TV: $tv, Main: $main_screen, Secondary: $secondary_screen"

dispatch_workspaces() {
    local monitor=$1
    log "Dispatching workspaces to $monitor"

    mapfile -t workspaces < <(hyprctl workspaces -j | jq -r '.[].id')

    for ws in "${workspaces[@]}"; do
        if [[ "$monitor" == "$main_screen" && "$ws" == "9" ]]; then
            hyprctl dispatch moveworkspacetomonitor "9 $secondary_screen"
            log "Moved workspace 9 to $secondary_screen"
        else
            hyprctl dispatch moveworkspacetomonitor "$ws $monitor"
        fi
    done
}

disable_all_monitors() {
    local monitor=$1

    mapfile -t monitors < <(hyprctl -j monitors all | jq -r '.[] | select(.name != "'"$monitor"'") | .name')
    log "Disabling monitors: ${monitors[*]} (except: $monitor)"

    for mon in "${monitors[@]}"; do
        hyprctl keyword monitor "$mon, disable"
        log "Disabled monitor: $mon"
    done
}

# Detect current mode: check if TV is enabled
TV_ACTIVE=$(hyprctl -j monitors | jq -r '.[] | select(.name == "'"$tv"'") | .name' 2>/dev/null)
log "TV_ACTIVE: $TV_ACTIVE"

if [ "$TV_ACTIVE" = "$tv" ]; then
    # Currently in TV mode → switch to PC mode
    log "Switching to PC mode"
    disable_all_monitors "$main_screen"
    hyprctl keyword monitor "$main_screen, 2560x1440@164.96Hz, 0x0, 1"
    hyprctl keyword monitor "$secondary_screen, 1920x1080@60, auto-center-right, 1"
    log "Enabled $main_screen and $secondary_screen"
    PRIMARY="$main_screen"
else
    # Currently in PC mode → switch to TV mode
    log "Switching to TV mode"
    hyprctl keyword monitor "$tv, 2560x1440@60, auto-center-left, 2"
    disable_all_monitors "$tv"
    log "Enabled $tv"
    if ! hyprctl -j monitors | jq -e '.[] | select(.name == "'"$tv"'")' >/dev/null 2>&1; then
        log "WARNING: TV ($tv) not found in active monitors after dispatch"
    fi
    PRIMARY="$tv"
fi
dispatch_workspaces $PRIMARY

log "Script completed - PRIMARY: $PRIMARY"
log "Log file: $LOG_FILE"

killall qs
sleep 0.3
qs -c noctalia-shell & disown 
