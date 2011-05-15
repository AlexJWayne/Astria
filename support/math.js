(function() {
  Math.deg2rad = function(deg) {
    return deg * Math.PI / 180;
  };
  Math.rad2deg = function(rad) {
    return rad * 180 / Math.PI;
  };
  Math.sinD = function(deg) {
    return Math.sin(Math.deg2rad(deg));
  };
  Math.cosD = function(deg) {
    return Math.cos(Math.deg2rad(deg));
  };
  Math.tanD = function(deg) {
    return Math.tan(Math.deg2rad(deg));
  };
  Math.atan2D = function(y, x) {
    return Math.rad2deg(Math.atan2(y, x));
  };
  Math.between = function(a, b, progress) {
    if (progress == null) {
      progress = 0.5;
    }
    return a * (1 - progress) + b * progress;
  };
}).call(this);
