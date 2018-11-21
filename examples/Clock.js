exports.now = function() {
  const now = new Date();
  return {
    h: now.getHours(),
    m: now.getMinutes(),
    s: now.getSeconds(),
  };
};
