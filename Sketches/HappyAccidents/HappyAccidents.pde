import java.util.Map;

PShape s;
PShape[] asteroidShapes;

PFont rubik;

Player p;
GameManager gm;
ParticleSystem ps;

HashMap<Character, Boolean> kbInputs;

float deltaTime, startTime, currentTime;

char[] possibleInputs = {'w', 'a', 's', 'd', ' '};

void setup() {
  colorMode(HSB);
  shapeMode(CENTER);
  surface.setTitle("Jacob Desilets - Happy Accidents");
  size(1000, 800);

  s = loadShape("player.svg");
  
  rubik = createFont("RubikMonoOne-Regular.ttf", 32);
  textFont(rubik);
  textSize(20);

  asteroidShapes = new PShape[3];
  asteroidShapes[0] = loadShape("asteroid1.svg");
  asteroidShapes[1] = loadShape("asteroid2.svg");
  asteroidShapes[2] = loadShape("asteroid3.svg");

  p = new Player(s);
  ps = new ParticleSystem();
  gm = new GameManager(p, asteroidShapes, ps);

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
  
  ps.draw();
  
  if (gm.gameState.equals("PLAYING")) {
    p.kbInput(kbInputs);
    p.draw();
  }
  
  gm.manage();

  fill(0);
  
  text("SCORE: " + gm.score, 10, height-5);
  text("FPS: " + (int)  frameRate, 10, 20);

  if (gm.gameState.equals("GAMEOVER")) {
    textSize(40);
    text("GAME OVER", width/2 - 170, height/2);
    textSize(20);
    text("press r to continue", width/2 - 180, height/2 + 50);
    if(keyPressed && key=='r') {
      gm.score = 0;
      gm.gameState = "PLAYING";
      p.reset();
      gm.reset();
    }
  }
}


// keep track of which keys are pressed in the kbInputs hashmap
void keyPressed() {
  if (arrayContains(possibleInputs, key)) {
    kbInputs.put(key, true);
  }
}

void keyReleased() {
  if (arrayContains(possibleInputs, key)) {
    kbInputs.put(key, false);
  }
}
