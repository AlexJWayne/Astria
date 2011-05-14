(function() {
  var Wall;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  Artifact.Test1 = (function() {
    function Test1() {
      Test1.__super__.constructor.apply(this, arguments);
    }
    __extends(Test1, Artifact);
    Test1.prototype.createSubObjects = function() {
      return [new Wall(this.scene, v(200, 200, 20), v(0, 0, 110), 0), new Wall(this.scene, v(200, 200, 20), v(0, 0, -110), 0), new Wall(this.scene, v(200, 20, 200), v(0, 110, 0), 1), new Wall(this.scene, v(200, 20, 200), v(0, -110, 0), 1), new Wall(this.scene, v(20, 200, 200), v(110, 0, 0), 2), new Wall(this.scene, v(20, 200, 200), v(-110, 0, 0), 2)];
    };
    return Test1;
  })();
  Wall = (function() {
    var mats;
    __extends(Wall, Artifact.SubObject);
    mats = [
      new THREE.MeshLambertMaterial({
        color: 0xff0000,
        shading: THREE.FlatShading
      }), new THREE.MeshLambertMaterial({
        color: 0x00ff00,
        shading: THREE.FlatShading
      }), new THREE.MeshLambertMaterial({
        color: 0x0000ff,
        shading: THREE.FlatShading
      })
    ];
    function Wall(scene, size, position, matIndex, options) {
      this.scene = scene;
      this.size = size;
      this.matIndex = matIndex;
      if (options == null) {
        options = {};
      }
      Wall.__super__.constructor.call(this, this.scene, options);
      this.position.copy(position);
    }
    Wall.prototype.geometry = function() {
      return new THREE.Cube(this.size.x, this.size.y, this.size.z);
    };
    Wall.prototype.material = function() {
      return mats[this.matIndex];
    };
    Wall.prototype.onTouch = function() {
      return this.position.addSelf(this.position.clone().normalize().multiplyScalar(10));
    };
    return Wall;
  })();
}).call(this);
