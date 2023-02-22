class Cube {
  float x, y, size;
  int hue, sat;
  float lifetime;
  
  int timer, dt;
  
  boolean alive = true;
  
  Cube(float x, float y, float size, float lifetime) {
    
    hue = (int)random(0, 256);
    this.x = x;
    this.y = y;
    this.size = size;
    this.lifetime = lifetime;
     
    timer = millis();
    dt = 0;
    
    sat = 255;
  }
  
  void update() {
    dt = millis() - timer;
    if(dt > lifetime) { alive = false; }
    
    sat -= 255/lifetime;
  }
  
  void display() {
    if(alive) {
      cube.setFill(color(hue, sat, sat));
      pushMatrix();
      translate(x, y, 0);
      shape(cube);
      popMatrix();
    }
  }
}
