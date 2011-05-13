(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  this.Game = (function() {
    var bindEvents;
    function Game() {
      this.renderCamera = __bind(this.renderCamera, this);;
      this.render = __bind(this.render, this);;
      this.animate = __bind(this.animate, this);;
      this.mouseMove = __bind(this.mouseMove, this);;      this.camera = new THREE.Camera(75, window.innerWidth / window.innerHeight, 1, 10000);
      this.camera.position.z = 500;
      this.camera.orbit = {
        x: 30,
        y: 30
      };
      this.camera.last = {
        x: 30,
        y: 30
      };
      this.scene = new THREE.Scene();
      this.light = new THREE.DirectionalLight(0xffffff, 1.0, 500);
      this.scene.addObject(this.light);
      this.artifact = new Artifact(this.scene);
      this.renderer = new THREE.CanvasRenderer();
      this.renderer.setSize(window.innerWidth, window.innerHeight);
      document.body.appendChild(this.renderer.domElement);
      bindEvents.call(this);
    }
    bindEvents = function() {
      document.onmousemove = this.mouseMove;
      document.onmousedown = __bind(function(event) {
        var hits, _ref;
        hits = this.camera.castMouse(this.scene, event);
        if (hits.length > 0) {
          return (_ref = hits[0].object.owner) != null ? typeof _ref.onTouch == "function" ? _ref.onTouch() : void 0 : void 0;
        } else {
          this.camera.orbit.enabled = true;
          this.camera.last.x = event.clientX;
          return this.camera.last.y = event.clientY;
        }
      }, this);
      return document.onmouseup = __bind(function() {
        return this.camera.orbit.enabled = false;
      }, this);
    };
    Game.prototype.mouseMove = function(event) {
      var sensitivity;
      sensitivity = 540;
      if (this.camera.orbit.enabled) {
        this.camera.orbit.x += (event.clientX - this.camera.last.x) / window.innerWidth * sensitivity;
        if (this.camera.orbit.x > 360) {
          this.camera.orbit.x -= 360;
        }
        if (this.camera.orbit.x < 0) {
          this.camera.orbit.x += 360;
        }
        this.camera.last.x = event.clientX;
        this.camera.orbit.y += (event.clientY - this.camera.last.y) / window.innerHeight * sensitivity;
        if (this.camera.orbit.y > 90) {
          this.camera.orbit.y = 90;
        }
        if (this.camera.orbit.y < -90) {
          this.camera.orbit.y = -90;
        }
        return this.camera.last.y = event.clientY;
      }
    };
    Game.prototype.animate = function() {
      requestAnimationFrame(this.animate);
      return this.render();
    };
    Game.prototype.render = function() {
      this.renderCamera();
      return this.renderer.render(this.scene, this.camera);
    };
    Game.prototype.renderCamera = function() {
      var x, y, _ref;
      _ref = this.camera.orbit, x = _ref.x, y = _ref.y;
      this.camera.position.multiplyScalar(0);
      this.camera.position.x = -Math.sinD(x) * 500;
      this.camera.position.z = Math.cosD(x) * 500;
      this.camera.position.multiplyScalar(Math.cosD(y));
      return this.camera.position.y = Math.sinD(y) * 500;
    };
    return Game;
  })();
  THREE.Camera.prototype.castMouse = function(scene, event) {
    var hits, mousePos, ray, width;
    mousePos = v(event.clientX / window.innerWidth * 2 - 1, -(event.clientY / window.innerHeight * 2 - 1), 0);
    width = Math.tanD(this.fov / 2) * this.position.length();
    mousePos.multiplySelf(v(width, width / this.aspect, 0));
    mousePos.multiplyScalar(1.7);
    mousePos.rotateX(-this.orbit.y);
    mousePos.rotateY(-this.orbit.x);
    ray = new THREE.Ray(this.position, this.position.clone().negate().addSelf(mousePos));
    hits = ray.intersectScene(scene);
    return hits.sort(function(a, b) {
      if (a.distance > b.distance) {
        return 1;
      } else {
        return -1;
      }
    });
  };
}).call(this);
