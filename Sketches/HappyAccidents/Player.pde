class Player extends Movable {
  PShape s;
  // Stores all projectiles fired by the player
  // Projectiles should be deleted when off screen
  ArrayList<Projectile> projectiles;

  Player(PShape s) {
    super(width/2, height/2);
    this.s = s;
    projectiles = new ArrayList<Projectile>();

    collisionRadius = 10;
  }

  // Check hash map for pressed keys
  // this system can handle multiple key presses at once
  void kbInput(HashMap<Character, Boolean> inputs) {
    if (inputs.get('w')) {
      applyForce(PVector.fromAngle(rot - PI/2).setMag(.5));
    }
    if (inputs.get('s')) {
      applyForce(PVector.fromAngle(rot + PI/2).setMag(.1));
    }
    if (inputs.get('d')) {
      rot += 0.1;
    }
    if (inputs.get('a')) {
      rot -= 0.1;
    }
    if (inputs.get(' ')) {
      // Reset spacebar input so only fire once per press
      inputs.put(' ', false);
      shoot();
    }
  }

  void shoot() {
    projectiles.add(new Projectile(pos.x, pos.y, 5, rot - PI/2, 20 + vel.mag()));
  }

  void draw() {
    update();
    
    // pushMatrix - translate - popMatrix required to make object rotate around its center point
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(rot);
    shape(this.s, 0, 0, 40, 40);
    popMatrix();

    // update and draw all projectiles belonging to the player
    for (int i = projectiles.size()-1; i >= 0; i--) {
      Projectile proj = projectiles.get(i);
      if (proj.offScreen()) {  // dereference projectiles if they are off screen
        projectiles.remove(i);
        continue;
      }
      proj.update();
      proj.draw();
    }
  }

  void drawCollisionCircle() {
    stroke(0);
    noFill();
    ellipse(pos.x, pos.y, collisionRadius*2, collisionRadius*2);
  }
  
  // Override base class method to clear projectiles
  void reset() {
    super.reset();
    projectiles.clear();
  }
}

class Projectile extends Movable {
  float d;
  Projectile(float x, float y, float d, float rot, float mag) {
    super(x, y);
    this.rot = rot;
    this.d = d;
    applyForce(PVector.fromAngle(rot).setMag(mag));
    collisionRadius = d/2;
  }

  void draw() {
    fill(0);
    noStroke();
    ellipse(pos.x, pos.y, d, d);
  }

  boolean offScreen() {
    if (pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height) {
      return true;
    }
    return false;
  }
}
