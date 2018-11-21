"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.parseInt_ = function (s) {
    for (var i = 0; i < s.length; i++) {
        if (s[i] < '0' || s[i] > '9')
            return null;
    }
    return parseInt(s, 10);
};
exports.addListener = function (o) { return function () {
    var handler = function () {
        var l = document.location;
        var url = '';
        switch (o.mode) {
            case 'hash':
                url = l.hash.replace(/^#/, '');
                break;
            case 'history':
                url = l.pathname + l.search + l.hash;
                break;
        }
        o.handler(url)();
    };
    handler();
    window.addEventListener('popstate', handler);
    return handler;
}; };
exports.removeListener = function (handler) { return function () {
    window.removeEventListener('popstate', handler);
}; };
var go = function (type, url) {
    switch (type) {
        case 'push':
            history.pushState({}, '', url);
            break;
        case 'replace':
            history.replaceState({}, '', url);
            break;
    }
    window.dispatchEvent(new Event('popstate'));
};
exports.onClick = function (e) { return function () {
    if (e.ctrlKey || e.metaKey || e.altKey || e.shiftKey || e.button !== 0) {
        return;
    }
    var node = e.currentTarget || e.target;
    if (node instanceof Element) {
        var url = node.getAttribute('href');
        var target = node.getAttribute('target');
        if ((url && url[0] !== '/') || target) {
            return;
        }
        e.preventDefault();
        e.stopPropagation();
        if (url) {
            go('push', url);
        }
    }
}; };
exports.push_ = function (url) { return function () {
    go('push', url);
}; };
exports.replace_ = function (url) { return function () {
    go('replace', url);
}; };
