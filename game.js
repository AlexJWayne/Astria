(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  this.Game = (function() {
    function Game() {
      this.render = __bind(this.render, this);;
      this.animate = __bind(this.animate, this);;      var light;
      this.camera = new OrbitCamera(75, window.innerWidth / window.innerHeight, 1, 10000);
      this.cameraOrbiting = false;
      this.scene = new THREE.Scene();
      light = new THREE.DirectionalLight(0xffffff, 1.0, 500);
      light.position.set(0, 1, 0.25);
      this.scene.addObject(light);
      this.scene.addObject(new THREE.AmbientLight(0x888888));
      this.renderer = new THREE.CanvasRenderer();
      this.renderer.setSize(window.innerWidth, window.innerHeight);
      document.body.appendChild(this.renderer.domElement);
      this.artifact = new Artifact.Test1(this.scene);
      __bind(function() {
        document.onmousemove = __bind(function(event) {
          if (this.cameraOrbiting) {
            return this.camera.move(event);
          }
        }, this);
        document.onmousedown = __bind(function(event) {
          var hits, _ref;
          if ((hits = this.camera.castMouse(this.scene, event)).length > 0) {
            return (_ref = hits[0].object) != null ? typeof _ref.onTouch == "function" ? _ref.onTouch() : void 0 : void 0;
          } else {
            this.cameraOrbiting = true;
            this.camera.last.x = event.clientX;
            return this.camera.last.y = event.clientY;
          }
        }, this);
        return document.onmouseup = __bind(function() {
          return this.cameraOrbiting = false;
        }, this);
      }, this)();
    }
    Game.prototype.animate = function() {
      requestAnimationFrame(this.animate);
      return this.render();
    };
    Game.prototype.render = function() {
      this.camera.updateOrbit();
      return this.renderer.render(this.scene, this.camera);
    };
    return Game;
  })();
}).call(this);
