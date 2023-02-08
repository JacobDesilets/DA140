import java.util.Collections;
import java.util.Arrays;

int waitTime = 1000;
long now;
long last;
long deltaTime;

boolean click = false;

GameManager gm;

void setup() {
  size(500, 500);
  colorMode(HSB);
  
  gm = new GameManager(4,4);
  
  now = 0;
  last = 0;
  deltaTime = 0;
}

void draw() {
  if(mousePressed) { click = true; }
  if(click && !mousePressed) {
    gm.mouseCheck(mouseX, mouseY);
    click = false;
  }
  
  
  gm.display();
  surface.setTitle("Score " + gm.score);
}
