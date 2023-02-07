class Ball {
  PVector pos, vel, acc;
  float mass;
  int hue;
  int id;
  
  final static float BOUNCE = 0.95;
  final static float GRAVITY = 0.1;
  
  Ball(float x, float y, float mass, int id) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    this.mass = mass;
    this.id = id;
    hue = (int) random(256);
    
    randomForce(random(10,100));
  }
  
  void randomForce(float mag) {
    applyForce(PVector.fromAngle(random(2*PI)).setMag(mag));
  }
  
  void update(ArrayList<Ball> others) {
    // F = M * A
    PVector gravity = PVector.fromAngle(PI/2).setMag(GRAVITY * mass);
    applyForce(gravity);
    
    edgeCollide();
    
    for(Ball other : others) {
      if(id != other.id) {
        ballCollide(other);
      }
    }
    
    vel.add(acc);
    pos.add(vel);
    
    
    
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
  
  boolean mouseOver(float x, float y) {
    return (dist(pos.x, pos.y, x, y) <= mass/2);
  }
  
  void ballCollide(Ball other) {
    // if the distance between the centers of the two balls is less
    // than this, they have collided
    float collisionDistance = (mass / 2) + (other.mass / 2);
    float distance = abs(dist(pos.x, pos.y, other.pos.x, other.pos.y));
    
    
    if(distance <= collisionDistance) {
      // https://gamedevelopment.tutsplus.com/tutorials/when-worlds-collide-simulating-circle-circle-collisions--gamedev-769
      float newVX = ((2 * other.mass * other.vel.x) + (vel.x * (mass - other.mass))) / (mass + other.mass);
      float newVY = ((2 * other.mass * other.vel.y) + (vel.y * (mass - other.mass))) / (mass + other.mass);
      
      float otherNewVX = ((2 * mass * vel.x) + (other.vel.x * (other.mass - mass))) / (mass + other.mass);
      float otherNewVY = ((2 * mass * vel.y) + (other.vel.y * (other.mass - mass))) / (mass + other.mass);
      
      vel.x = newVX;
      vel.y = newVY;
      
      other.vel.x = otherNewVX;
      other.vel.y = otherNewVY;
      
      // Ensures that balls don't get stuck inside each other
      pos.x += newVX;
      pos.y += newVY;
      other.pos.x += otherNewVX;
      other.pos.y += otherNewVY;
    }
    
  }
}
