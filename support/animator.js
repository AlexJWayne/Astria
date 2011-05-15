(function() {
  var __slice = Array.prototype.slice;
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
      this.alive = true;
    }
    Animator.prototype.progress = function() {
      var result;
      result = this.elapsed / this.duration;
      this.expired = result >= 1;
      this.animating = !this.expired;
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
