// 
class Particle extends Movable {
  float life, r;
  int hue, c;

  Particle(float x, float y, float r, int hue) {
    super(x, y);
    this.r = r;
    this.hue = hue;
    
    c = color(hue, 255, 255);

    // Disable screen wrapping for particles
    doWrap = false;
    life = 255;

    friction = 0.95;
  }

  void draw() {
    life -= 1.0;
    c = lerpColor(c, color(255), .01);

    noStroke();
    fill(c);

    ellipse(pos.x, pos.y, 2*r, 2*r);
  }
}

// Handles spawning, despawning, and rendering of particles
class ParticleSystem {
  ArrayList<Particle> particles;

  ParticleSystem() {
    particles = new ArrayList<Particle>();
  }

  void createParticles(float x, float y, int count) {
    for (int i = 0; i < count; i++) {
      // particles have random size and color
      Particle p = new Particle(x, y, random(5), (int)random(255));
      // and fly in random directions at random speeds
      p.applyForce(PVector.fromAngle(random(2*PI)).setMag(random(5, 15)));
      particles.add(p);
    }
  }

  void draw() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.update();
      p.draw();
      // Dereference particles once their life runs out
      if (p.life <= 0) {
        particles.remove(i);
      }
    }
  }
}
