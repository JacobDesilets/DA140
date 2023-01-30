import java.util.Map;

PShape s;
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
  p = new Player(s);
  
  gm = new GameManager(p);
  
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
  if(gm.gameState.equals("PLAYING")) {
    p.kbInput(kbInputs);
    p.draw();
    //p.drawCollisionCircle();
    
    fill(0);
    text("FPS: " + frameRate, 10, 10);
    //am.spawn();
    gm.manage();
    
    fill(0);
    text("SCORE: " + gm.score, 10, height);
  } else if(gm.gameState.equals("GAMEOVER")) {
    
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
