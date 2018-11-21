export const setInterval_ = (ms: number) => (fn: () => () => void) => () => {
  return setInterval(() => fn()(), ms);
};

export const clearInterval_ = (id: NodeJS.Timeout) => () => clearInterval(id);
