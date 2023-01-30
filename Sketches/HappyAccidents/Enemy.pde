class Asteroid extends Movable {
  int c;
  float r;
  
  
  Asteroid(float x, float y, float r) {
    super(x, y);
    friction = 1;
    this.r = r;
    collisionRadius = r;
    
    // Spawn asteroids with random color
    c = color(random(256), 255, 255);
  }
  
  void draw() {
    fill(c);
    noStroke();
    ellipse(pos.x, pos.y, 2*r, 2*r);
  }
}
