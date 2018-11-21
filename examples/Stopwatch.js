exports.now = function() {
  return +new Date() / 1000;
};

exports.toFixed = function(number) {
  return function(digits) {
    return number.toFixed(digits);
  };
};
