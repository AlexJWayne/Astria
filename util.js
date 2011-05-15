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
  Math.between = function(a, b, progress) {
    if (progress == null) {
      progress = 0.5;
    }
    return a * (1 - progress) + b * progress;
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
  this.Animator = (function() {
    Animator.linear = function(progress) {
      return progress;
    };
    Animator.ease = function(progress) {
      return (1 - Math.cos(progress * Math.PI)) / 2;
    };
    Animator.easein = function(progress) {
      return 1 - Math.cos(progress * Math.PI / 2);
    };
    Animator.easeout = function(progress) {
      return Math.cos((progress - 1) * Math.PI / 2);
    };
    function Animator() {
      var args, callback, options, _i;
      args = 2 <= arguments.length ? __slice.call(arguments, 0, _i = arguments.length - 1) : (_i = 0, []), callback = arguments[_i++];
      this.callback = callback;
      this.duration = args[0];
      options = args[1] || {};
      this.curve = options.curve || Animator.ease;
      Game.animators.push(this);
      this.start = Game.lastFrameAt;
      this.elapsed = 0;
      this.expired = false;
    }
    Animator.prototype.progress = function() {
      var result;
      result = this.elapsed / this.duration;
      this.expired = result >= 1;
      if (result > 1) {
        return 1;
      } else {
        return result;
      }
    };
    Animator.prototype.update = function() {
      this.elapsed = Game.lastFrameAt - this.start;
      return this.callback(this.curve(this.progress()));
    };
    return Animator;
  })();
}).call(this);
