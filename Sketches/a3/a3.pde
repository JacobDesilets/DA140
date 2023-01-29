// Jacob Desilets
// 1/15/23
// DA140

final int MIN_WEIGHT = 1;
final int MAX_WEIGHT = 100;
int BG_COLOR, BLACK;

boolean rbHeld = false;

BlackBrush blackBrush;
RainbowBrush rbBrush;
Eraser eraser;

void setup() {
  size(1000, 800);
  colorMode(HSB);
  BG_COLOR = color(0, 0, 255);
  BLACK = color(0);
  background(BG_COLOR);
  
  blackBrush = new BlackBrush();
  rbBrush = new RainbowBrush();
  eraser = new Eraser();
}


void draw() {
  rbBrush.update();
  
  if(mousePressed) {
    if(mouseButton == LEFT) {
      if(!rbHeld) {
        blackBrush.paint(mouseX, mouseY, pmouseX, pmouseY);
      } else {
        rbBrush.paint(mouseX, mouseY, pmouseX, pmouseY);
      }
    } else if(mouseButton == RIGHT) {
      eraser.paint(mouseX, mouseY, pmouseX, pmouseY);
    }
  }
  
  drawInfo();
}

void keyPressed() {
  switch(key) {
  case 'r':
    rbHeld = true;
    break;
  case 'w':
    blackBrush.changeWeight(1);
    rbBrush.changeWeight(1);
    eraser.changeWeight(1);
    break;
  case 's':
    blackBrush.changeWeight(-1);
    rbBrush.changeWeight(-1);
    eraser.changeWeight(-1);
    break;
  case 'c':
    background(BG_COLOR);
    break;
  }
}

void keyReleased() {
  switch(key) {
  case 'r':
    rbHeld = false;
    break;
  }
}

void drawInfo() {
  noStroke();
  fill(color(0));
  rect(0, height - 20, width, height);
  fill(color(0, 0, 255));
  textSize(18);
  text("Jacob Desilets", width - 115, height - 4);
  text("Stroke Weight:  " + blackBrush.weight, 8, height - 4);
  text("[w]: ↑ [s]: ↓", 155, height - 4);
  text("[c]: clear    [r]: rainbow    [lmb]: draw    [rmb]: erase", 275, height - 4);
  
}

class Brush {
  int weight = 4;
  
  void draw(int mX, int mY, int pMX, int pMY) {
    strokeWeight(weight);
    line(mX, mY, pMX, pMY);
  }
  
  void changeWeight(int change) {
    int wouldBe = weight + change;
    if(wouldBe >= MIN_WEIGHT && wouldBe <= MAX_WEIGHT) {
      weight = wouldBe;
    }
  }
}

class BlackBrush extends Brush {
  void paint(int mX, int mY, int pMX, int pMY) {
    stroke(BLACK);
    draw(mX, mY, pMX, pMY);
  }
}

class RainbowBrush extends Brush {
  int hue = 0;
  
  void update() {
    if(hue >= 255) {
      hue = 0;
    } else {
      hue++;
    }
  }
  
  void paint(int mX, int mY, int pMX, int pMY) {
    stroke(hue, 255, 255);
    draw(mX, mY, pMX, pMY);
  }
}

class Eraser extends Brush {
  void paint(int mX, int mY, int pMX, int pMY) {
    stroke(BG_COLOR);
    draw(mX, mY, pMX, pMY);
  }
}
