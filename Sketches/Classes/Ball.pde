class Ball {
  PVector pos, vel, acc;
  float mass;
  int hue;
  
  final static float BOUNCE = 0.95;
  final static float GRAVITY = 0.1;
  
  Ball(float x, float y, float mass) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    this.mass = mass;
    hue = (int) random(256);
    
    randomForce();
  }
  
  void randomForce() {
    applyForce(PVector.fromAngle(random(2*PI)).setMag(random(100)));
  }
  
  void update() {
    // F = M * A
    PVector gravity = PVector.fromAngle(PI/2).setMag(GRAVITY * mass);
    applyForce(gravity);
    
    vel.add(acc);
    pos.add(vel);
    
    edgeCollide();
    
    acc.mult(0);
  }
  
  void display() {
    noStroke();
    fill(hue, 255, 255);
    ellipse(pos.x, pos.y, mass, mass);
  }
  
  void applyForce(PVector force) {
    // A = F / M
    acc.add(PVector.div(force, mass));
  }
  
  void edgeCollide() {
    float radius = mass / 2;
    if(pos.x > width-radius) {
      pos.x = width-radius;
      vel.x *= -BOUNCE;
    } else if(pos.x < radius) {
      pos.x = radius;
      vel.x *= -BOUNCE;
    } else if(pos.y > height-radius) {
      pos.y = height-radius;
      vel.y *= -BOUNCE;
    } else if(pos.y < radius) {
      pos.y = radius;
      vel.y *= -BOUNCE;
    }
  }
  
  void ballCollide(Ball other) {
    // if the distance between the centers of the two balls is less
    // than this, they have collided
    float collisionDistance = (mass / 2) + (other.mass / 2);
    float distance = abs(dist(pos.x, pos.y, other.pos.x, other.pos.y));
    if(distance <= collisionDistance) {
      
    }
    
  }
}
