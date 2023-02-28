ParticleSystem ps;

void setup() {
  colorMode(HSB);
  size(500, 500);
  ps = new ParticleSystem();
}

void draw() {
  background(0);
  ps.run();
}

void mouseReleased() {
  ps.createParticles(mouseX, mouseY, 20);
}
