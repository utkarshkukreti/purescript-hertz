exports.now = function() {
  const now = new Date();
  return now - now.getTimezoneOffset() * 60 * 1000;
};

exports.modulo = function(a) {
  return function(b) {
    return a % b;
  };
};
