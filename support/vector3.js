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
  THREE.Vector3.prototype.rotateX = function(deg) {
    return this.set(this.x, this.y * Math.cosD(deg) - this.z * Math.sinD(deg), this.y * Math.sinD(deg) + this.z * Math.cosD(deg));
  };
  THREE.Vector3.prototype.rotateY = function(deg) {
    return this.set(this.z * Math.sinD(deg) + this.x * Math.cosD(deg), this.y, this.z * Math.cosD(deg) - this.x * Math.sinD(deg));
  };
  THREE.Vector3.prototype.rotateZ = function(deg) {
    return this.set(this.x * Math.cosD(deg) - this.y * Math.sinD(deg), this.x * Math.sinD(deg) + this.y * Math.cosD(deg), this.z);
  };
  THREE.Vector3.prototype.setBetween = function(a, b, progress) {
    if (progress == null) {
      progress = 0.5;
    }
    return this.set(Math.between(a.x, b.x, progress), Math.between(a.y, b.y, progress), Math.between(a.z, b.z, progress));
  };
}).call(this);
