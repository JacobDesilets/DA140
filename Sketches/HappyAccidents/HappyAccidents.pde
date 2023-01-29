import java.util.Map;

PShape s;
Player p;

HashMap<Character, Boolean> kbInputs;

float deltaTime, startTime, currentTime;

char[] possibleInputs = {'w', 'a', 's', 'd', ' '};

void setup() {
  shapeMode(CENTER);
  surface.setTitle("Jacob Desilets - Happy Accidents");
  size(1000, 800);
  
  s = loadShape("player.svg");
  p = new Player(s);
  
  deltaTime = 0;
  startTime = System.nanoTime();
  
  kbInputs = new HashMap<Character, Boolean>();
  for (char c : possibleInputs) {
    kbInputs.put(c, false);
  }
}

void draw() {
  //currentTime = System.nanoTime();
  //deltaTime = (currentTime - startTime) / 1_000_000_000;
  //startTime = currentTime;
  
  background(255);
  p.kbInput(kbInputs);
  p.update();
  p.draw();
  p.drawCollisionCircle();
  
  fill(0);
  text("FPS: " + frameRate, 10, 10); 
}

void keyPressed() {
  if(arrayContains(possibleInputs, key)) {
    kbInputs.put(key, true);
  }
}

void keyReleased() {
  if(arrayContains(possibleInputs, key)) {
    kbInputs.put(key, false);
  }
}
