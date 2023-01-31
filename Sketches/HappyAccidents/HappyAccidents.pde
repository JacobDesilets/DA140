import java.util.Map;

PShape s;
//PShape a1;
//PShape a2;
//PShape a3;
PShape[] asteroidShapes;

Player p;
GameManager gm;

HashMap<Character, Boolean> kbInputs;

float deltaTime, startTime, currentTime;

char[] possibleInputs = {'w', 'a', 's', 'd', ' '};

void setup() {
  colorMode(HSB);
  shapeMode(CENTER);
  surface.setTitle("Jacob Desilets - Happy Accidents");
  size(1000, 800);
  
  s = loadShape("player.svg");
  
  //a1 = loadShape("asteroid1.svg");
  //a2 = loadShape("asteroid2.svg");
  //a3 = loadShape("asteroid3.svg");
  asteroidShapes = new PShape[3];
  asteroidShapes[0] = loadShape("asteroid1.svg");
  asteroidShapes[1] = loadShape("asteroid2.svg");
  asteroidShapes[2] = loadShape("asteroid3.svg");
  
  p = new Player(s);
  
  gm = new GameManager(p, asteroidShapes);
  
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
  if(gm.gameState.equals("PLAYING")) { p.kbInput(kbInputs); }
  p.draw();
  //p.drawCollisionCircle();
  
  fill(0);
  text("FPS: " + frameRate, 10, 10);
  //am.spawn();
  gm.manage();
  
  fill(0);
  text("SCORE: " + gm.score, 10, height);
  
  if(gm.gameState.equals("GAMEOVER")) {
    
  }
    
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
