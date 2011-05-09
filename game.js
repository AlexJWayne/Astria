(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  this.Game = (function() {
    function Game() {
      this.renderCamera = __bind(this.renderCamera, this);;
      this.render = __bind(this.render, this);;
      this.animate = __bind(this.animate, this);;
      this.mouseMove = __bind(this.mouseMove, this);;      this.camera = new THREE.Camera(75, window.innerWidth / window.innerHeight, 1, 10000);
      this.camera.position.z = 500;
      this.camera.orbit = {
        x: 0,
        y: 0
      };
      this.camera.last = {
        x: 0,
        y: 0
      };
      this.scene = new THREE.Scene();
      this.model = new Model();
      this.scene.addObject(this.model.mesh);
      this.renderer = new THREE.CanvasRenderer();
      this.renderer.setSize(window.innerWidth, window.innerHeight);
      document.body.appendChild(this.renderer.domElement);
      document.onmousemove = this.mouseMove;
      document.onmousedown = __bind(function(event) {
        this.camera.orbit.enabled = true;
        this.camera.last.x = event.clientX;
        return this.camera.last.y = event.clientY;
      }, this);
      document.onmouseup = __bind(function() {
        return this.camera.orbit.enabled = false;
      }, this);
    }
    Game.prototype.mouseMove = function(event) {
      var sensitivity;
      sensitivity = 3;
      if (this.camera.orbit.enabled) {
        this.camera.orbit.x += (event.clientX - this.camera.last.x) / window.innerWidth * sensitivity;
        if (this.camera.orbit.x > 1) {
          this.camera.orbit.x -= 2;
        }
        if (this.camera.orbit.x < -1) {
          this.camera.orbit.x += 2;
        }
        this.camera.last.x = event.clientX;
        console.log(this.camera.orbit.x);
        this.camera.orbit.y += (event.clientY - this.camera.last.y) / window.innerHeight * sensitivity;
        if (this.camera.orbit.y > 0.5) {
          this.camera.orbit.y = 0.5;
        }
        if (this.camera.orbit.y < -0.5) {
          this.camera.orbit.y = -0.5;
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
      this.camera.position.x = -Math.sin(x * Math.PI) * 500;
      this.camera.position.z = Math.cos(x * Math.PI) * 500;
      this.camera.position.multiplyScalar(Math.cos(y * Math.PI));
      return this.camera.position.y = Math.sin(y * Math.PI) * 500;
    };
    return Game;
  })();
}).call(this);
