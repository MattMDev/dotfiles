// ==UserScript==
// @name         9animetv.to Adblocker
// @namespace    https://9animetv.to
// @version      1.1
// @description  Block ads and popups on 9animetv.to
// @match        *://9animetv.to/*
// @match        *://*.9animetv.to/*
// @match        *://aniwave.to/*
// @match        *://*.aniwave.to/*
// @match        *://vidstream.pro/*
// @match        *://*.vidstream.pro/*
// @match        *://mcloud.to/*
// @match        *://*.mcloud.to/*
// @match        *://vizcloud.online/*
// @match        *://*.vizcloud.online/*
// @grant        GM_addStyle
// @grant        window.onurlchange
// @run-at       document-start
// ==/UserScript==

(function() {
    'use strict';

    const adSelectors = [
        '.ads',
        '.ad',
        '.advertisement',
        '[class*="ads-"]',
        '[class*="ad-"]',
        '[id*="ads-"]',
        '[id*="ad-"]',
        '[class*="banner"]',
        '[id*="banner"]',
        'iframe[src*="ads"]',
        'iframe[src*="doubleclick"]',
        'iframe[src*="googlesyndication"]',
        '.popunder',
        '.popup',
        '.modal-ad',
        '.video-ads',
        '.jw-ad-skip',
        '.jw-ad-skip-button',
        '.ad-overlay',
        '.ad-container',
        '[data-ad]',
        '[data-ad-slot]',
        '.sponsored',
        '.promo',
        '.sticky-ad',
        '.dfp-ad',
        'div[class*="google_ads"]',
        'ins.adsbygoogle',
        '.adbreak',
        '.ad-break'
    ];

    const popupOverlaySelectors = [
        '.overlay',
        '[class*="overlay"]',
        '[id*="overlay"]',
        '.modal',
        '[class*="modal"]',
        '[id*="modal"]',
        '.lightbox',
        '[class*="lightbox"]',
        '.fancybox',
        '[class*="fancybox"]',
        '.popup-overlay',
        '[class*="popup"]',
        '[id*="popup"]',
        '[class*="dialog"]',
        '[id*="dialog"]',
        '[role="dialog"]',
        '[aria-modal="true"]',
        '.告知',
        '[class*="告知"]'
    ];

    const adDomains = [
        'doubleclick.net',
        'googlesyndication.com',
        'googleadservices.com',
        'googletag.com',
        'googletagmanager.com',
        'google-analytics.com',
        'moatads.com',
        'adnxs.com',
        'adsrvr.org',
        'advertising.com',
        'adcolony.com',
        'admob.com',
        'adsymptotic.com',
        'adtech.de',
        'amazon-adsystem.com',
        'applift.com',
        'applovin.com',
        'bidswitch.net',
        'casalemedia.com',
        'chartboost.com',
        'contextweb.com',
        'criteo.com',
        'criteo.net',
        'demdex.net',
        'exponential.com',
        'eyeota.net',
        'fyber.com',
        'indexww.com',
        'inmobi.com',
        'ironsrc.com',
        'kochava.com',
        'liveramp.com',
        'lijit.com',
        'mediamath.com',
        'millennialmedia.com',
        'mobvista.com',
        'mookie1.com',
        'openx.net',
        'outbrain.com',
        'pubmatic.com',
        'quantserve.com',
        'rlcdn.com',
        'rubiconproject.com',
        'scorecardresearch.com',
        'serving-sys.com',
        'sharethrough.com',
        'simpli.fi',
        'smartadserver.com',
        'spotxchange.com',
        'taboola.com',
        'tapad.com',
        'thetradedesk.com',
        'tidaltv.com',
        'traffichaus.com',
        'tvsquared.com',
        'unity3d.com',
        'unityads.unity3d.com',
        'vungle.com',
        'yieldmo.com',
        'zedo.com'
    ];

    function removeAdElements() {
        adSelectors.forEach(selector => {
            try {
                document.querySelectorAll(selector).forEach(el => {
                    el.style.display = 'none';
                    el.style.visibility = 'hidden';
                    el.style.opacity = '0';
                    el.style.pointerEvents = 'none';
                    el.style.height = '0';
                    el.style.overflow = 'hidden';
                });
            } catch (e) {
            }
        });
    }

    function hideAntiAdblockMessage() {
        const antiAdblockSelectors = [
            '[class*="adblock"]',
            '[id*="adblock"]',
            '.adblock-warning',
            '.adblock-detect',
            '.ad-block',
            '.block-adblock',
            '[class*="disable-adblock"]',
            '[id*="disable-adblock"]'
        ];

        antiAdblockSelectors.forEach(selector => {
            try {
                document.querySelectorAll(selector).forEach(el => {
                    el.style.display = 'none';
                });
            } catch (e) {
            }
        });
    }

    function hidePopupOverlays() {
        popupOverlaySelectors.forEach(selector => {
            try {
                document.querySelectorAll(selector).forEach(el => {
                    const style = window.getComputedStyle(el);
                    const rect = el.getBoundingClientRect();
                    
                    if (rect.width > 0 && rect.height > 0) {
                        if (style.position === 'fixed' || style.position === 'absolute') {
                            if (rect.width > window.innerWidth * 0.5 || rect.height > window.innerHeight * 0.5) {
                                el.style.display = 'none';
                                el.style.visibility = 'hidden';
                            }
                        }
                    }
                });
            } catch (e) {
            }
        });
    }

    function hideFullscreenOverlays() {
        try {
            const allElements = document.querySelectorAll('*');
            allElements.forEach(el => {
                const style = window.getComputedStyle(el);
                const rect = el.getBoundingClientRect();
                
                if (rect.width >= window.innerWidth && rect.height >= window.innerHeight) {
                    if (style.position === 'fixed' && style.zIndex >= 9999) {
                        if (!el.querySelector('video') && !el.querySelector('canvas')) {
                            el.style.display = 'none';
                            el.style.visibility = 'hidden';
                        }
                    }
                }
            });
        } catch (e) {
        }
    }

    function addClickToCloseHandler() {
        document.addEventListener('click', function(e) {
            const target = e.target;
            const html = document.documentElement;
            
            if (target === html || target.tagName === 'BODY') {
                const overlays = document.querySelectorAll('.overlay, [class*="overlay"], [class*="popup"], [id*="popup"], [role="dialog"]');
                overlays.forEach(el => {
                    const style = window.getComputedStyle(el);
                    const rect = el.getBoundingClientRect();
                    if (rect.width > 0 && rect.height > 0 && 
                        (style.position === 'fixed' || style.position === 'absolute') &&
                        rect.width > window.innerWidth * 0.4) {
                        el.style.display = 'none';
                    }
                });
            }
        }, true);
    }

    function blockPopups() {
        let blockedPopups = 0;
        const originalOpen = window.open;
        const originalShowModalDialog = window.showModalDialog;

        window.open = function() {
            blockedPopups++;
            console.log('[9animetv Adblock] Blocked popup #' + blockedPopups);
            return null;
        };

        window.showModalDialog = function() {
            blockedPopups++;
            console.log('[9animetv Adblock] Blocked modal #' + blockedPopups);
            return null;
        };
    }

    function preventRedirects() {
        document.addEventListener('click', function(e) {
            const link = e.target.closest('a');
            if (link && link.href) {
                const suspiciousDomains = adDomains.map(d => d.replace('.', '\\.')).join('|');
                const suspiciousPattern = new RegExp(suspiciousDomains, 'i');
                
                if (suspiciousPattern.test(link.href)) {
                    e.preventDefault();
                    e.stopPropagation();
                    console.log('[9animetv Adblock] Blocked suspicious redirect');
                    return false;
                }
            }
        }, true);

        document.addEventListener('submit', function(e) {
            const form = e.target;
            if (form && form.action) {
                const suspiciousDomains = adDomains.map(d => d.replace('.', '\\.')).join('|');
                const suspiciousPattern = new RegExp(suspiciousDomains, 'i');
                
                if (suspiciousPattern.test(form.action)) {
                    e.preventDefault();
                    console.log('[9animetv Adblock] Blocked suspicious form submission');
                    return false;
                }
            }
        }, true);
    }

    function blockAdScripts() {
        const originalCreateElement = document.createElement;
        const originalAppendChild = document.appendChild;
        
        const scriptTypes = [
            'text/advertisement',
            'text/ads',
            'application/javascript'
        ];

        const observer = new MutationObserver((mutations) => {
            mutations.forEach((mutation) => {
                mutation.addedNodes.forEach((node) => {
                    if (node.nodeType === Node.ELEMENT_NODE) {
                        if (scriptTypes.includes(node.type) || 
                            (node.tagName === 'SCRIPT' && node.src && 
                             adDomains.some(d => node.src.includes(d)))) {
                            node.remove();
                        }
                        if (node.tagName === 'IFRAME') {
                            const src = node.src || '';
                            if (adDomains.some(d => src.includes(d))) {
                                node.remove();
                            }
                        }
                    }
                });
            });
        });

        observer.observe(document.documentElement, {
            childList: true,
            subtree: true
        });
    }

    function addBlockingStyles() {
        const css = `
            .ads, .ad, .advertisement, [class*="ads-"], [class*="ad-"],
            [id*="ads-"], [id*="ad-"], [class*="banner"], [id*="banner"],
            .popunder, .popup, .modal-ad, .video-ads, .jw-ad-skip,
            .jw-ad-skip-button, .ad-overlay, .ad-container, [data-ad],
            [data-ad-slot], .sponsored, .promo, .sticky-ad, .dfp-ad,
            div[class*="google_ads"], ins.adsbygoogle, .adbreak, .ad-break,
            [class*="adblock"], [id*="adblock"], .adblock-warning,
            .adblock-detect, .ad-block, .block-adblock,
            [class*="disable-adblock"], [id*="disable-adblock"] {
                display: none !important;
                visibility: hidden !important;
                opacity: 0 !important;
                pointer-events: none !important;
                height: 0 !important;
                width: 0 !important;
                overflow: hidden !important;
            }
            
            .overlay, [class*="overlay"], [id*="overlay"],
            .modal, [class*="modal"], [id*="modal"],
            .lightbox, [class*="lightbox"], .fancybox,
            .popup-overlay, [class*="popup"], [id*="popup"],
            [class*="dialog"], [id*="dialog"], [role="dialog"],
            [aria-modal="true"] {
                display: none !important;
                visibility: hidden !important;
            }
            
            body {
                overflow-x: hidden !important;
            }
            
            body::before {
                content: "";
                position: fixed;
                top: 0;
                left: 0;
                width: 100vw;
                height: 100vh;
                z-index: 2147483647;
                pointer-events: none;
            }
        `;
        
        if (typeof GM_addStyle !== 'undefined') {
            GM_addStyle(css);
        } else {
            const style = document.createElement('style');
            style.textContent = css;
            document.head.appendChild(style);
        }
    }

    function init() {
        addBlockingStyles();
        blockPopups();
        preventRedirects();
        blockAdScripts();
        addClickToCloseHandler();

        const removeInterval = setInterval(() => {
            removeAdElements();
            hideAntiAdblockMessage();
            hidePopupOverlays();
            hideFullscreenOverlays();
        }, 300);

        setTimeout(() => {
            clearInterval(removeInterval);
        }, 60000);

        if (typeof window.onurlchange !== 'undefined') {
            window.addEventListener('urlchange', (info) => {
                addBlockingStyles();
                removeAdElements();
                hideAntiAdblockMessage();
                hidePopupOverlays();
            });
        }

        window.addEventListener('load', () => {
            removeAdElements();
            hideAntiAdblockMessage();
            hidePopupOverlays();
        });
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }

})();
5
