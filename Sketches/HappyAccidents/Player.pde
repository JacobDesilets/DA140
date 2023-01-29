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
  ArrayList<Projectile> projectiles;
  
  // Constructor
  Player(PShape s) {
    super(width/2, height/2);
    this.s = s;
    projectiles = new ArrayList<Projectile>();
  }
  
  void kbInput(HashMap<Character, Boolean> inputs) {
    if(inputs.get('w')) {
      applyForce(PVector.fromAngle(rot - PI/2).setMag(1));
    }
    if(inputs.get('s')) {
      applyForce(PVector.fromAngle(rot + PI/2).setMag(.5));
    }
    if(inputs.get('d')) {
      rot += 0.1;
    }
    if(inputs.get('a')) {
      rot -= 0.1;
    }
    if(inputs.get(' ')) {
      shoot();
    }
  }
  
  void shoot() {
    projectiles.add(new Projectile(pos.x, pos.y, 5, rot - PI/2, 20 + vel.mag()));
  }
  
  void draw() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(rot);
    shape(this.s, 0, 0, 40, 40);
    popMatrix();
    
    for(int i = projectiles.size()-1; i >= 0; i--) {
      Projectile proj = projectiles.get(i);
      if(proj.offScreen()) {
        projectiles.remove(i);
        continue;
      }
      proj.update();
      proj.draw();
    }
  }
}

class Projectile extends Movable {
  float d;
  Projectile(float x, float y, float d, float rot, float mag) {
    super(x, y);
    this.rot = rot;
    this.d = d;
    applyForce(PVector.fromAngle(rot).setMag(mag));
  }
  
  void draw() {
    fill(0);
    noStroke();
    ellipse(pos.x, pos.y, d, d);
  }
  
  boolean offScreen() {
    if(pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height) {
      return true;
    }
    return false;
  }
} 
