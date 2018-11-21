"use strict";
var __extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
        return extendStatics(d, b);
    }
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
Object.defineProperty(exports, "__esModule", { value: true });
var inferno = require("inferno");
exports.text = function (value) { return inferno.createTextVNode(value); };
var PROPERTY = 1;
var ON = 2;
var CLASS = 3;
var REF = 4;
var KEY = 5;
exports.property = function (name) { return function (value) { return [
    PROPERTY,
    name,
    value,
]; }; };
exports.on = function (name) { return function (handler) { return [ON, name, handler]; }; };
exports.class_ = function (name) { return [CLASS, name]; };
exports.ref_ = function (handler) { return [
    REF,
    handler,
]; };
exports.key = function (name) { return [KEY, name]; };
var linkEvent = function (data, event) {
    data(event)();
};
exports.element = function (name) { return function (properties) { return function (children) {
    var props = {};
    var className = null;
    var ref = null;
    var key = null;
    var _loop_1 = function (i) {
        var property_1 = properties[i];
        switch (property_1[0]) {
            case 1:
                props[property_1[1]] = property_1[2];
                break;
            case 2:
                props['on' + property_1[1]] = inferno.linkEvent(property_1[2], linkEvent);
                break;
            case 3:
                if (className) {
                    className += ' ' + property_1[1];
                }
                else {
                    className = property_1[1];
                }
                break;
            case 4:
                ref = function (_) { return property_1[1](_)(); };
                break;
            case 5:
                key = property_1[1];
                break;
        }
    };
    for (var i = 0; i < properties.length; i++) {
        _loop_1(i);
    }
    return inferno.createVNode(inferno.getFlagsForElementVnode(name), name, className, children, 0 /* UnknownChildren */, props, key, ref);
}; }; };
exports.none = false;
exports.component_ = function (name) { return function (spec) {
    var Component = /** @class */ (function (_super) {
        __extends(Component, _super);
        function Component(props) {
            var _this = _super.call(this) || this;
            _this.send = function (action) { return function () {
                spec.update(_this.self)(action)();
            }; };
            _this.state = { _: spec.initialize(props._)() };
            _this.self = {
                props: function () { return _this.props._; },
                get: function () { return _this.state._; },
                put: function (_) { return function () { return _this.setState({ _: _ }); }; },
                modify: function (f) { return function () { return _this.setState(function (_) { return ({ _: f(_._) }); }); }; },
                send: _this.send,
            };
            _this.subscriptions = [];
            return _this;
        }
        Component.prototype.render = function () {
            return spec.render({
                props: this.props._,
                state: this.state._,
                send: this.send,
            });
        };
        Component.prototype.componentDidMount = function () {
            if (spec.didMount) {
                spec.didMount(this.self)();
            }
            this.syncSubscriptions();
        };
        Component.prototype.shouldComponentUpdate = function (nextProps, nextState) {
            if (spec.shouldUpdate) {
                return spec.shouldUpdate({
                    prevProps: this.props._,
                    prevState: this.state._,
                    nextProps: nextProps._,
                    nextState: nextState._,
                })();
            }
            else {
                return true;
            }
        };
        Component.prototype.componentDidUpdate = function (prevProps, prevState) {
            if (spec.didUpdate) {
                spec.didUpdate(this.self)(prevProps._)(prevState._)();
            }
            this.syncSubscriptions();
        };
        Component.prototype.componentWillUnmount = function () {
            if (spec.willUnmount) {
                spec.willUnmount({
                    props: this.props._,
                    state: this.state._,
                })();
            }
        };
        Component.prototype.syncSubscriptions = function () {
            if (!spec.subscriptions)
                return;
            var newSubscriptions = spec.subscriptions({
                props: this.props._,
                state: this.state._,
            });
            for (var i = 0; i < Math.max(this.subscriptions.length, newSubscriptions.length); i++) {
                var o = this.subscriptions[i];
                var n = newSubscriptions[i];
                if (o && n && o.spec === n.spec) {
                    n.state = o.spec.update({
                        props: n.props,
                        state: o.state,
                        send: this.send,
                    })();
                }
                else {
                    if (o) {
                        o.spec.destroy({
                            props: o.props,
                            state: o.state,
                            send: this.send,
                        })();
                    }
                    if (n) {
                        n.state = n.spec.initialize({
                            props: n.props,
                            send: this.send,
                        })();
                    }
                }
            }
            this.subscriptions = newSubscriptions;
        };
        Component.displayName = name;
        return Component;
    }(inferno.Component));
    return Component;
}; };
exports.make = function (component) { return function (props) {
    return inferno.createComponentVNode(4 /* ComponentClass */, component, { _: props }, null, null);
}; };
exports.render = function (selector) { return function (vnode) { return function () {
    var element = document.querySelector(selector);
    if (element) {
        inferno.render(vnode, element);
    }
    else {
        console.error("no element matching the selector \"" + selector + "\" found in the document");
    }
}; }; };
exports.log = function (x) { return function () { return console.log(x); }; };
