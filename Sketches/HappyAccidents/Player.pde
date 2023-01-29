class Movable {
  PVector pos, vel, acc;
  float rot, friction, maxVel;
  boolean alive;
  
  Movable(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    
    rot = 0;
    friction = 0.99;
    maxVel = 50;
    alive = true;
  }
  
  void update() {
    wrap();
    vel.add(acc);
    vel.limit(maxVel);
    vel.mult(friction);
    pos.add(vel);
    
    acc.mult(0);
  }
  
  void applyForce(PVector force) {
    acc.add(force);
  }
  
  void wrap() {
    if (pos.x < -50) { pos.x = width; }
    if (pos.x > width + 50) { pos.x = 0; }
    if (pos.y < -50) { pos.y = height; }
    if (pos.y > height + 50) { pos.y = 0; }
  }
}

class Player extends Movable { 
  PShape s;
  
  // Constructor
  Player(PShape s) {
    super(width/2, height/2);
    this.s = s;
  }
  
  void kbInput(char k) {
    switch(k) {
      case 'w':
        applyForce(PVector.fromAngle(rot - PI/2).setMag(1));
        break;
      case 's':
        applyForce(PVector.fromAngle(rot + PI/2).setMag(.5));
        break;
      case 'd':
        rot += 0.1;
        break;
      case 'a':
        rot -= 0.1;
        break;
    } 
  }
  
  void draw() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(rot);
    shape(this.s, 0, 0, 40, 40);
    popMatrix();
  }
}

class Projectile extends Movable {
  Projectile(float x, float y) {
    super(x, y);
  }
} 
