(function() {
  var Wall;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  }, __slice = Array.prototype.slice, __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  Artifact.Test1 = (function() {
    __extends(Test1, Artifact);
    function Test1() {
      var args;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      Test1.__super__.constructor.apply(this, args);
      this.activatedWalls = [];
    }
    Test1.prototype.createSubObjects = function() {
      return [new Wall(this.scene, v(200, 200, 20), v(0, 0, 110), 0), new Wall(this.scene, v(200, 200, 20), v(0, 0, -110), 3), new Wall(this.scene, v(200, 20, 200), v(0, 110, 0), 4), new Wall(this.scene, v(200, 20, 200), v(0, -110, 0), 2), new Wall(this.scene, v(20, 200, 200), v(110, 0, 0), 1), new Wall(this.scene, v(20, 200, 200), v(-110, 0, 0), 5)];
    };
    Test1.prototype.deactivateOtherWalls = function(wall) {
      var obj, _i, _len, _ref, _results;
      _ref = this.subObjects;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        obj = _ref[_i];
        _results.push(obj.popped && obj !== wall ? obj.animate(false) : void 0);
      }
      return _results;
    };
    Test1.prototype.activateWall = function(wall) {
      var obj, _i, _len, _ref, _ref2;
      _ref = this.subObjects;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        obj = _ref[_i];
        if ((_ref2 = wall.animator) != null ? _ref2.animating : void 0) {
          return;
        }
      }
      if (wall.order === this.activatedWalls.length) {
        this.activatedWalls.push(wall);
        if (!wall.popped) {
          wall.animate(true);
        }
        if (this.activatedWalls.length === 1) {
          this.deactivateOtherWalls(wall);
        }
      } else {
        this.activatedWalls = [];
        this.deactivateOtherWalls(wall);
        wall.animate(!wall.popped);
      }
      if (this.activatedWalls.length === 6) {
        return setTimeout(__bind(function() {
          alert('A winner is you! Resetting...');
          this.activatedWalls = [];
          return setTimeout(__bind(function() {
            return this.deactivateOtherWalls();
          }, this), 500);
        }, this), 500);
      }
    };
    return Test1;
  })();
  Wall = (function() {
    var mats;
    __extends(Wall, Artifact.SubObject);
    mats = [
      new THREE.MeshLambertMaterial({
        color: 0x000000,
        shading: THREE.FlatShading
      }), new THREE.MeshLambertMaterial({
        color: 0x2a2a2a,
        shading: THREE.FlatShading
      }), new THREE.MeshLambertMaterial({
        color: 0x444444,
        shading: THREE.FlatShading
      }), new THREE.MeshLambertMaterial({
        color: 0x888888,
        shading: THREE.FlatShading
      }), new THREE.MeshLambertMaterial({
        color: 0xbbbbbb,
        shading: THREE.FlatShading
      }), new THREE.MeshLambertMaterial({
        color: 0xffffff,
        shading: THREE.FlatShading
      })
    ];
    function Wall(scene, size, position, order, options) {
      this.scene = scene;
      this.size = size;
      this.order = order;
      if (options == null) {
        options = {};
      }
      Wall.__super__.constructor.call(this, this.scene, options);
      this.position.copy(position);
      this.popped = false;
    }
    Wall.prototype.geometry = function() {
      return new THREE.Cube(this.size.x, this.size.y, this.size.z);
    };
    Wall.prototype.material = function() {
      return mats[this.order];
    };
    Wall.prototype.onTouch = function() {
      return this.artifact.activateWall(this);
    };
    Wall.prototype.animate = function(outward) {
      var curve, goal, start;
      this.popped = outward;
      start = this.position.clone();
      goal = this.position.clone().addSelf(this.position.clone().normalize().multiplyScalar(outward ? 50 : -50));
      curve = outward ? Animator.easeout : Animator.easein;
      return this.animator = new Animator(0.5, {
        curve: Animator.easeout
      }, __bind(function(progress) {
        return this.position.setBetween(start, goal, progress);
      }, this));
    };
    return Wall;
  })();
}).call(this);
