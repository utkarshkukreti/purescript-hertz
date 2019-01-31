import * as inferno from 'inferno';
import { VNodeFlags, ChildFlags } from 'inferno-vnode-flags';

export const text = (value: string) => inferno.createTextVNode(value);

type Property =
  | [typeof PROPERTY, string, any]
  | [typeof ON, string, (_: Event) => () => void]
  | [typeof CLASS, string]
  | [typeof REF, (_: Element | null) => () => void]
  | [typeof KEY, string];

const PROPERTY = 1;
const ON = 2;
const CLASS = 3;
const REF = 4;
const KEY = 5;

export const property = (name: string) => (value: any): Property => [
  PROPERTY,
  name,
  value,
];

export const on = (name: string) => (
  handler: (_: Event) => () => void
): Property => [ON, name, handler];

export const class_ = (name: string): Property => [CLASS, name];

export const ref_ = (handler: (_: Element | null) => () => void): Property => [
  REF,
  handler,
];

export const key = (name: string): Property => [KEY, name];

const linkEvent = (data: (_: Event) => () => void, event: Event) => {
  data(event)();
};

export const element = (name: string) => (properties: Property[]) => (
  children: inferno.VNode[]
): inferno.VNode => {
  const props: any = {};
  let className: string | null = null;
  let ref: inferno.Ref | null = null;
  let key: string | null = null;

  for (let i = 0; i < properties.length; i++) {
    const property = properties[i];
    switch (property[0]) {
      case PROPERTY:
        props[property[1]] = property[2];
        break;
      case ON:
        props['on' + property[1]] = inferno.linkEvent(property[2], linkEvent);
        break;
      case CLASS:
        if (className) {
          className += ' ' + property[1];
        } else {
          className = property[1];
        }
        break;
      case REF:
        ref = (_: Element | null) => property[1](_)();
        break;
      case KEY:
        key = property[1];
        break;
    }
  }

  return inferno.createVNode(
    inferno.getFlagsForElementVnode(name),
    name,
    className,
    children,
    ChildFlags.UnknownChildren,
    props,
    key,
    ref
  );
};

export const none = false;

type Spec<Props, State, Action> = {
  initialize: Initialize<Props, State, Action>;
  update: Update<Props, State, Action>;
  render: Render<Props, State, Action>;
  subscriptions?: Subscriptions<Props, State, Action>;
  didMount?: DidMount<Props, State, Action>;
  shouldUpdate?: ShouldUpdate<Props, State, Action>;
  didUpdate?: DidUpdate<Props, State, Action>;
  willUnmount?: WillUnmount<Props, State, Action>;
};

type Initialize<Props, State, _Action> = (_: Props) => () => State;

type Update<Props, State, Action> = (
  _: Self<Props, State, Action>
) => (_: Action) => () => void;

type Render<Props, State, Action> = (
  _: {
    props: Props;
    state: State;
    send: Send<Action>;
  }
) => inferno.VNode;

type Subscriptions<Props, State, Action> = (
  _: {
    props: Props;
    state: State;
  }
) => Subscription<Props, State, Action>[];

type Subscription<Props, State, Action> = {
  spec: SubscriptionSpec<Props, State, Action>;
  props: Props;
  state: State;
};

type SubscriptionSpec<Props, State, Action> = {
  initialize: (
    _: {
      props: Props;
      send: Send<Action>;
    }
  ) => () => State;
  update: (
    _: {
      props: Props;
      state: State;
      send: Send<Action>;
    }
  ) => () => State;
  destroy: (
    _: {
      props: Props;
      state: State;
      send: Send<Action>;
    }
  ) => () => void;
};

type DidMount<Props, State, Action> = (
  _: Self<Props, State, Action>
) => () => void;

type ShouldUpdate<Props, State, _Action> = (
  _: {
    prevProps: Props;
    prevState: State;
    nextProps: Props;
    nextState: State;
  }
) => () => boolean;

type DidUpdate<Props, State, Action> = (
  _: Self<Props, State, Action>
) => (_: Props) => (_: State) => () => void;

type WillUnmount<Props, State, _Action> = (
  _: {
    props: Props;
    state: State;
  }
) => () => void;

type Self<Props, State, Action> = {
  props: () => Props;
  get: () => State;
  put: (_: State) => () => void;
  modify: (_: (_: State) => State) => () => void;
  send: Send<Action>;
};

type Send<Action> = (_: Action) => () => void;

export const component_ = <Props, State, Action>(name: string) => (
  spec: Spec<Props, State, Action>
) => {
  class Component extends inferno.Component<{ _: Props }, { _: State }> {
    static displayName = name;

    self: Self<Props, State, Action>;
    state: { _: State };
    subscriptions: Subscription<any, any, any>[];

    constructor(props: { _: Props }) {
      super();
      this.state = { _: spec.initialize(props._)() };
      this.self = {
        props: () => this.props._,
        get: () => this.state!._,
        put: _ => () => this.setState({ _ }),
        modify: f => () => this.setState(_ => ({ _: f(_._) })),
        send: this.send,
      };
      this.subscriptions = [];
    }

    send = (action: Action) => () => {
      spec.update(this.self)(action)();
    };

    render() {
      return spec.render({
        props: this.props._,
        state: this.state!._,
        send: this.send,
      });
    }

    componentDidMount() {
      if (spec.didMount) {
        spec.didMount(this.self)();
      }
      this.syncSubscriptions();
    }

    shouldComponentUpdate(nextProps: { _: Props }, nextState: { _: State }) {
      if (spec.shouldUpdate) {
        return spec.shouldUpdate({
          prevProps: this.props._,
          prevState: this.state._,
          nextProps: nextProps._,
          nextState: nextState._,
        })();
      } else {
        return true;
      }
    }

    componentDidUpdate(prevProps: { _: Props }, prevState: { _: State }) {
      if (spec.didUpdate) {
        spec.didUpdate(this.self)(prevProps._)(prevState._)();
      }
      this.syncSubscriptions();
    }

    componentWillUnmount() {
      if (spec.willUnmount) {
        spec.willUnmount({
          props: this.props._,
          state: this.state._,
        })();
      }
    }

    syncSubscriptions() {
      if (!spec.subscriptions) return;
      const newSubscriptions = spec.subscriptions({
        props: this.props._,
        state: this.state._,
      });
      for (
        let i = 0;
        i < Math.max(this.subscriptions.length, newSubscriptions.length);
        i++
      ) {
        const o = this.subscriptions[i];
        const n = newSubscriptions[i];
        if (o && n && o.spec === n.spec) {
          n.state = o.spec.update({
            props: n.props,
            state: o.state,
            send: this.send,
          })();
        } else {
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
    }
  }
  return Component;
};

export const make = <Props>(component: inferno.IComponent<Props, any>) => (
  props: Props
): inferno.VNode =>
  inferno.createComponentVNode(
    VNodeFlags.ComponentClass,
    component,
    { _: props },
    null,
    null
  );

export const makeKeyed = <Props>(key: string) => (
  component: inferno.IComponent<Props, any>
) => (props: Props): inferno.VNode =>
  inferno.createComponentVNode(
    VNodeFlags.ComponentClass,
    component,
    { _: props },
    key,
    null
  );

export const render = (selector: string) => (vnode: inferno.VNode) => () => {
  const element = document.querySelector(selector);
  if (element) {
    inferno.render(vnode, element);
  } else {
    console.error(
      `no element matching the selector "${selector}" found in the document`
    );
  }
};

export const log = (x: any) => () => console.log(x);
