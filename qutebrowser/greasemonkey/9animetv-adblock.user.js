// ==UserScript==
// @name         9animetv.to Adblocker
// @namespace    https://9animetv.to
// @version      1.3
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

    window.goqonBlocked = true;

    const originalCreateElement = document.createElement.bind(document);
    document.createElement = function(tagName, options) {
        const el = originalCreateElement(tagName, options);
        if (tagName.toLowerCase() === 'script') {
            const originalSrc = Object.getOwnPropertyDescriptor(HTMLScriptElement.prototype, 'src');
            Object.defineProperty(el, 'src', {
                set: function(value) {
                    if (value && value.includes('goqon.com')) {
                        console.log('[9animetv Adblock] Blocked script from goqon.com');
                        return;
                    }
                    originalSrc.set.call(this, value);
                },
                get: originalSrc ? originalSrc.get.bind(el) : function() { return ''; }
            });
        }
        return el;
    };

    const originalAppendChild = Node.prototype.appendChild;
    Node.prototype.appendChild = function(node) {
        if (node && node.src && typeof node.src === 'string' && node.src.includes('goqon.com')) {
            console.log('[9animetv Adblock] Blocked appendChild of goqon.com script');
            return node;
        }
        return originalAppendChild.call(this, node);
    };

    const originalInsertBefore = Node.prototype.insertBefore;
    Node.prototype.insertBefore = function(newNode, refNode) {
        if (newNode && newNode.src && typeof newNode.src === 'string' && newNode.src.includes('goqon.com')) {
            console.log('[9animetv Adblock] Blocked insertBefore of goqon.com script');
            return newNode;
        }
        return originalInsertBefore.call(this, newNode, refNode);
    };

    if (typeof GM_addStyle !== 'undefined') {
        GM_addStyle(`
            [src*="goqon.com"], [href*="goqon.com"], iframe[src*="goqon.com"],
            div[style*="goqon.com"], div[data-src*="goqon.com"] {
                display: none !important;
            }
            body > div:last-child[style*="fixed"],
            body > div:last-child[class*="popup"],
            body > div:last-child[class*="modal"] {
                display: none !important;
            }
        `);
    }

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
        '[class*="告知"]',
        '[class*="subscribe"]',
        '[class*="notification"]',
        '[id*="notification"]',
        '[class*="promo"]',
        '.disclaimer',
        '[class*="disclaimer"]',
        '[class*="age-verify"]',
        '[class*="age-verif"]',
        '.close-btn',
        '[class*="close-btn"]',
        '[class*="closebtn"]',
        '.close-button',
        '[class*="close-button"]',
        '[class*="ad-modal"]',
        '[class*="adModal"]',
        '.video-ad',
        '[class*="video-ad"]',
        '[class*="interstitial"]'
    ];

    const adDomains = [
        'goqon.com',
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

        try {
            const body = document.body;
            if (body) {
                const children = body.children;
                for (const child of children) {
                    const style = window.getComputedStyle(child);
                    const rect = child.getBoundingClientRect();
                    if (rect.width >= window.innerWidth * 0.8 && rect.height >= window.innerHeight * 0.5) {
                        if (style.position === 'fixed' || style.position === 'absolute') {
                            const hasVideo = child.querySelector('video, iframe[src*="video"], canvas');
                            const hasInput = child.querySelector('input, textarea, select');
                            if (!hasVideo && !hasInput) {
                                child.style.display = 'none';
                                child.style.visibility = 'hidden';
                            }
                        }
                    }
                }
            }
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

        const adDomainsRegex = new RegExp(adDomains.map(d => d.replace('.', '\\.')).join('|'), 'i');

        const observer = new MutationObserver((mutations) => {
            mutations.forEach((mutation) => {
                mutation.addedNodes.forEach((node) => {
                    if (node.nodeType === Node.ELEMENT_NODE) {
                        if (scriptTypes.includes(node.type) || 
                            (node.tagName === 'SCRIPT' && node.src && adDomainsRegex.test(node.src))) {
                            node.remove();
                        }
                        if (node.tagName === 'IFRAME') {
                            const src = node.src || '';
                            if (adDomainsRegex.test(src)) {
                                node.remove();
                            }
                        }
                        if (node.tagName === 'IMG' || node.tagName === 'DIV' || node.tagName === 'SPAN') {
                            const src = node.src || node.getAttribute('data-src') || '';
                            const bg = window.getComputedStyle(node).backgroundImage;
                            if (adDomainsRegex.test(src) || (bg && bg !== 'none' && adDomainsRegex.test(bg))) {
                                node.style.display = 'none';
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
        }, 100);

        setTimeout(() => {
            clearInterval(removeInterval);
        }, 120000);

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

        new MutationObserver(() => {
            removeAdElements();
            hidePopupOverlays();
            hideFullscreenOverlays();
        }).observe(document.body, { childList: true, subtree: true });
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }

})();
5
