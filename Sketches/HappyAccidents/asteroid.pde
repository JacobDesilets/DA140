class Asteroid extends Movable {
  int c;
  float r;
  PShape s;
  float rot;
  float rotSpeed;
  
  Asteroid(float x, float y, float r, PShape s) {
    super(x, y);
    friction = 1;
    this.r = r;
    collisionRadius = r;
    this.s = s;
    
    // asteroids will rotate by a random speed
    rot = 0;
    rotSpeed = random(0.05);
  }

  void draw() {
    fill(c);
    noStroke();
    //ellipse(pos.x, pos.y, 2*r, 2*r);
    
    rot += rotSpeed;
    
    // pushMatrix - translate - popMatrix required to make object rotate around its center point
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(rot);
    shape(this.s, 0, 0, 2*r, 2*r);
    popMatrix();
  }
}
