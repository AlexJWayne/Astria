(function() {
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
      this.subObjects = this.createSubObjects();
    }
    Artifact.prototype.createSubObjects = function() {
      return [new SubObject(this.scene)];
    };
    return Artifact;
  })();
  this.Artifact.SubObject = (function() {
    __extends(SubObject, THREE.Mesh);
    function SubObject(scene, options) {
      this.scene = scene;
      if (options == null) {
        options = {};
      }
      SubObject.__super__.constructor.call(this, this.geometry(), this.material());
      this.scene.addObject(this);
    }
    SubObject.prototype.geometry = function() {
      return new THREE.Cube(10, 10, 10);
    };
    SubObject.prototype.material = function() {
      return new THREE.MeshBasicMaterial({
        color: 0xff00ff
      });
    };
    SubObject.prototype.onTouch = null;
    return SubObject;
  })();
}).call(this);
