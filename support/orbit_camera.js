(function() {
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  }, __slice = Array.prototype.slice;
  this.OrbitCamera = (function() {
    var defaults;
    __extends(OrbitCamera, THREE.Camera);
    defaults = {
      sensitivity: 500,
      distance: 500,
      startingOrbit: new THREE.Vector2(45, 30)
    };
    function OrbitCamera() {
      var args;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      OrbitCamera.__super__.constructor.apply(this, args);
      this.sensitivity = defaults.sensitivity, this.distance = defaults.distance;
      this.orbit = defaults.startingOrbit.clone();
      this.last = defaults.startingOrbit.clone();
    }
    OrbitCamera.prototype.move = function(event) {
      this.orbit.x += (event.clientX - this.last.x) / window.innerWidth * this.sensitivity;
      if (this.orbit.x > 360) {
        this.orbit.x -= 360;
      }
      if (this.orbit.x < 0) {
        this.orbit.x += 360;
      }
      this.last.x = event.clientX;
      this.orbit.y += (event.clientY - this.last.y) / window.innerHeight * this.sensitivity;
      if (this.orbit.y > 90) {
        this.orbit.y = 90;
      }
      if (this.orbit.y < -90) {
        this.orbit.y = -90;
      }
      return this.last.y = event.clientY;
    };
    OrbitCamera.prototype.updateOrbit = function() {
      var x, y, _ref;
      _ref = this.orbit, x = _ref.x, y = _ref.y;
      this.position.multiplyScalar(0);
      this.position.x = -Math.sinD(x) * this.distance;
      this.position.z = Math.cosD(x) * this.distance;
      this.position.multiplyScalar(Math.cosD(y));
      return this.position.y = Math.sinD(y) * this.distance;
    };
    OrbitCamera.prototype.castMouse = function(scene, event) {
      var hits, matrix, ray;
      ray = new THREE.Ray();
      ray.origin.set(event.clientX / window.innerWidth * 2 - 1, -(event.clientY / window.innerHeight * 2 - 1), 0);
      matrix = this.matrixWorld.clone();
      matrix.multiplySelf(THREE.Matrix4.makeInvert(this.projectionMatrix));
      matrix.multiplyVector3(ray.origin);
      ray.direction = ray.origin.clone().subSelf(this.position);
      hits = ray.intersectScene(scene);
      return hits.sort(function(a, b) {
        if (a.distance > b.distance) {
          return 1;
        } else {
          return -1;
        }
      });
    };
    return OrbitCamera;
  })();
}).call(this);
