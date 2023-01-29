// Base class for all moving game objects
// Provides acceleration based movement and screen wrapping
class Movable {
  PVector pos, vel, acc;
  float rot, friction, maxVel;
  boolean alive;
  float collisionRadius;
  
  Movable(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    
    rot = 0;
    friction = 0.99;
    maxVel = 50;
    alive = true;
    collisionRadius = 20;
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
  
  boolean collisionCheck(float x, float y) {
    // for the sake of simplicity, just check the distance from the point to the center of the object
    if(dist(x, y, pos.x, pos.y) < collisionRadius) { return true; }
    return false;
  }
}


// Returns true if char array pi contains char i, false otherwise
boolean arrayContains(char[] pi, char i) {
  // Use linear search because pi will usually be small
  for (char c : pi) {
    if(c == i) {
      return true;
    }
  }
  return false;
}
