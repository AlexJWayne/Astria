(function() {
  this.Model = (function() {
    function Model() {
      this.geometry = new THREE.Cube(200, 200, 200);
      this.material = new THREE.MeshBasicMaterial({
        color: 0xff0000,
        wireframe: true
      });
      this.mesh = new THREE.Mesh(this.geometry, this.material);
    }
    return Model;
  })();
}).call(this);
