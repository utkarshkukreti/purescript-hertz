export const parseInt_ = (s: string): number | null => {
  for (let i = 0; i < s.length; i++) {
    if (s[i] < '0' || s[i] > '9') return null;
  }
  return parseInt(s, 10);
};

export const addListener = (o: {
  mode: 'hash' | 'history';
  handler: (_: string) => () => void;
}) => () => {
  const handler = () => {
    const l = document.location!;
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
};

export const removeListener = (handler: () => void) => () => {
  window.removeEventListener('popstate', handler);
};

const go = (type: 'push' | 'replace', url: string) => {
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

exports.onClick = (e: MouseEvent) => () => {
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
};

export const push_ = (url: string) => () => {
  go('push', url);
};

export const replace_ = (url: string) => () => {
  go('replace', url);
};
