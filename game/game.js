(function() {
  var Game, func, method;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  Game = {
    init: function() {
      var light;
      this.startedAt = this.now();
      this.lastFrameAt = this.now();
      this.deltaTime = 0;
      this.elapsedTime = 0;
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
      this.animators = [];
      this.stats = new Stats();
      this.stats.domElement.style.position = 'absolute';
      this.stats.domElement.style.left = '5px';
      this.stats.domElement.style.top = '5px';
      document.body.appendChild(this.stats.domElement);
      this.bindMouseEvents();
      this.artifact = new Artifact.Test1(this.scene);
      return this.animate();
    },
    bindMouseEvents: function() {
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
    },
    now: function() {
      return new Date().getTime() / 1000;
    },
    animate: function() {
      requestAnimationFrame(this.animate);
      return this.render();
    },
    render: function() {
      var now;
      this.camera.updateOrbit();
      this.animators = _.reject(this.animators, function(animator) {
        animator.update();
        return animator.expired;
      });
      this.renderer.render(this.scene, this.camera);
      now = this.now();
      this.deltaTime = now - this.lastFrameAt;
      this.elapsedTime = now - this.startedAt;
      this.lastFrameAt = now;
      return this.stats.update();
    }
  };
  for (method in Game) {
    func = Game[method];
    Game[method] = _.bind(func, Game);
  }
  window.Game = Game;
}).call(this);
