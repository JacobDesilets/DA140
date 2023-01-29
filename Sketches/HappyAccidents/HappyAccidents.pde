PShape s;
Player p;

float deltaTime, startTime, currentTime;

void setup() {
  shapeMode(CENTER);
  surface.setTitle("Jacob Desilets - Happy Accidents");
  size(500, 500);
  
  s = loadShape("player.svg");
  p = new Player(s);
  
  deltaTime = 0;
  startTime = System.nanoTime();
}

void draw() {
  //currentTime = System.nanoTime();
  //deltaTime = (currentTime - startTime) / 1_000_000_000;
  //startTime = currentTime;
  
  background(255);
  p.update();
  p.draw();
  
  if(keyPressed) {
    p.kbInput(key);
  }
  
  fill(0);
  text(p.pos.x + " " + p.pos.y, 10, 10); 
  
}
