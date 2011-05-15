(function() {
  var __slice = Array.prototype.slice;
  this.v = function() {
    var args;
    args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    return (function(func, args, ctor) {
      ctor.prototype = func.prototype;
      var child = new ctor, result = func.apply(child, args);
      return typeof result == "object" ? result : child;
    })(THREE.Vector3, args, function() {});
  };
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
  THREE.Vector3.prototype.rotateX = function(deg) {
    var y, z;
    y = this.y, z = this.z;
    this.y = y * Math.cosD(deg) - z * Math.sinD(deg);
    this.z = y * Math.sinD(deg) + z * Math.cosD(deg);
    return this;
  };
  THREE.Vector3.prototype.rotateY = function(deg) {
    var x, z;
    x = this.x, z = this.z;
    this.x = z * Math.sinD(deg) + x * Math.cosD(deg);
    this.z = z * Math.cosD(deg) - x * Math.sinD(deg);
    return this;
  };
  THREE.Vector3.prototype.rotateZ = function(deg) {
    var x, y;
    x = this.x, y = this.y;
    this.x = x * Math.cosD(deg) - y * Math.sinD(deg);
    this.y = x * Math.sinD(deg) + y * Math.cosD(deg);
    return this;
  };
  this.Animator = (function() {
    function Animator() {}
    return Animator;
  })();
}).call(this);
