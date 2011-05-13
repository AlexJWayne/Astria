(function() {
  var SubObject, Wall;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  this.Artifact = (function() {
    function Artifact(scene) {
      this.scene = scene;
      this.subObjects = [new Wall(this.scene, v(200, 200, 20), v(0, 0, 110), 0), new Wall(this.scene, v(200, 200, 20), v(0, 0, -110), 0), new Wall(this.scene, v(200, 20, 200), v(0, 110, 0), 1), new Wall(this.scene, v(200, 20, 200), v(0, -110, 0), 1), new Wall(this.scene, v(20, 200, 200), v(110, 0, 0), 2), new Wall(this.scene, v(20, 200, 200), v(-110, 0, 0), 2)];
    }
    return Artifact;
  })();
  SubObject = (function() {
    function SubObject(scene, options) {
      this.scene = scene;
      if (options == null) {
        options = {};
      }
      this.mesh = this.mesh();
      this.mesh.owner = this;
      this.scene.addObject(this.mesh);
    }
    SubObject.prototype.geometry = function() {
      return new THREE.Cube(10, 10, 10);
    };
    SubObject.prototype.material = function() {
      return new THREE.MeshBasicMaterial({
        color: 0xff00ff
      });
    };
    SubObject.prototype.mesh = function() {
      var m;
      m = new THREE.Mesh(this.geometry(), this.material());
      m.owner = this;
      return m;
    };
    SubObject.prototype.onTouch = null;
    return SubObject;
  })();
  Wall = (function() {
    var mats;
    __extends(Wall, SubObject);
    mats = [
      new THREE.MeshBasicMaterial({
        color: 0xff0000
      }), new THREE.MeshBasicMaterial({
        color: 0x00ff00
      }), new THREE.MeshBasicMaterial({
        color: 0x0000ff
      })
    ];
    function Wall(scene, size, position, matIndex, options) {
      this.scene = scene;
      this.size = size;
      this.position = position;
      this.matIndex = matIndex;
      if (options == null) {
        options = {};
      }
      Wall.__super__.constructor.call(this, this.scene, options);
    }
    Wall.prototype.geometry = function() {
      return new THREE.Cube(this.size.x, this.size.y, this.size.z);
    };
    Wall.prototype.material = function() {
      return mats[this.matIndex];
    };
    Wall.prototype.mesh = function() {
      var mesh;
      mesh = Wall.__super__.mesh.call(this);
      mesh.position.copy(this.position);
      return mesh;
    };
    Wall.prototype.onTouch = function() {
      return this.mesh.position.addSelf(this.mesh.position.clone().normalize().multiplyScalar(10));
    };
    return Wall;
  })();
}).call(this);
