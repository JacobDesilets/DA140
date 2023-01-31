class Asteroid extends Movable {
  int c;
  float r;
  PShape s;
  
  
  Asteroid(float x, float y, float r, PShape s) {
    super(x, y);
    friction = 1;
    this.r = r;
    collisionRadius = r;
    this.s = s;
    
    // Spawn asteroids with random color
    c = color(random(256), 255, 255);
  }
  
  void draw() {
    fill(c);
    noStroke();
    //ellipse(pos.x, pos.y, 2*r, 2*r);
    shape(this.s, pos.x, pos.y, 2*r, 2*r);
  }
}
