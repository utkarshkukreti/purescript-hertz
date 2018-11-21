"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.setInterval_ = function (ms) { return function (fn) { return function () {
    return setInterval(function () { return fn()(); }, ms);
}; }; };
exports.clearInterval_ = function (id) { return function () { return clearInterval(id); }; };
