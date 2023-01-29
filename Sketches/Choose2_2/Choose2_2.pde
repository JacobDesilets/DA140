/*
Jacob Desilets
1/25/23
DA140

Revisit the idea of allowing the user to draw on the screen. 
But this time, present a selection of 5 different paint colors along the bottom of the screen. 
Whichever color the user clicks, is the color they can paint with! 
Remember to include an eraser, along with a full screen wipe if they wish to reset their drawing.
*/

import java.util.function.IntConsumer;

final int MIN_WEIGHT = 1;
final int MAX_WEIGHT = 100;

int BG, BLACK, RED, BLUE, GREEN, ORANGE;

Brush[] brushes = new Brush[6];
int currentBrush = 1;  // Start with black brush selected

UIBox menuBar;
ColorButton[] buttons = new ColorButton[5];


void setup() {
  rectMode(CORNERS);
  size(500, 500);
  colorMode(HSB);
  
  BG = color(0, 0, 255);
  BLACK = color(0);
  RED = #FF0505;
  BLUE = #0567FF;
  GREEN = #02D126;
  ORANGE = #FF9008;
  
  int[] colors = {BG, BLACK, RED, BLUE, GREEN, ORANGE};
  
  for(int i = 0; i < brushes.length; i++) {
    brushes[i] = new Brush(colors[i]);
  }
  
  menuBar = new UIBox(0, height - 50, width, height);
  
  int interval = width / 5;
  for(int i = 0; i < buttons.length; i++) {
    buttons[i] = new ColorButton(i * interval, height-30, (i+1) * interval, height, colors[i+1], i, (id) -> currentBrush = id+1);
  }
  background(BG);
}

void draw() {
  if(mousePressed) {
    if(mouseButton == LEFT) {
        brushes[currentBrush].draw(mouseX, mouseY, pmouseX, pmouseY);
    } else {
      brushes[0].draw(mouseX, mouseY, pmouseX, pmouseY);
    }
  }
  drawMenu();
}

void drawMenu() {
  menuBar.draw();
  for(int i = 0; i < buttons.length; i++) {
    buttons[i].update(mouseX, mouseY);
    buttons[i].draw();
  }
}

void keyPressed() {
  switch(key) {
  case 'w':
    brushes[currentBrush].changeWeight(1);
    break;
  case 's':
    brushes[currentBrush].changeWeight(-1);
    break;
  case 'c':
    background(BG);
    break;
  }
}

class Brush {
  int c, weight;
  
  Brush(int c) {
    this.c = c;
    weight = 4;
  }
  
  void draw(int mX, int mY, int pMX, int pMY) {
    strokeWeight(weight);
    stroke(c);
    line(mX, mY, pMX, pMY);
  }
  
  void changeWeight(int change) {
    int wouldBe = weight + change;
    if(wouldBe >= MIN_WEIGHT && wouldBe <= MAX_WEIGHT) {
      weight = wouldBe;
    }
  }
}

class UIBox {
  int x1, y1, x2, y2;
  int c;
  
  UIBox(int x1, int y1, int x2, int y2) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    c = BG;
  }
  
  // Returns true if the given point (Eg. the mouse) is contained within this element
  boolean pointOver(int x, int y) {
    return (x > x1 && x < x2) && (y > y1 && y < y2);
  }
  
  
  void draw() {
    noStroke();
    fill(c);
    rect(x1, y1, x2, y2);
  }
}

class ColorButton extends UIBox {
  int id;
  boolean clicked = false;
  int clickedColor;
  int defaultColor;
  IntConsumer onClick;
  
  ColorButton(int x1, int y1, int x2, int y2, int c, int id, IntConsumer onClick) {
    super(x1, y1, x2, y2);
    this.id = id;
    this.c = c;
    clickedColor = color(hue(c), 255, 128);
    defaultColor = c;
    this.onClick = onClick;
  }
  
  void update(int x, int y) {
    if(pointOver(x, y) && mousePressed) {
      clicked = true;
      c = clickedColor;
    } else {
      clicked = false;
      c = defaultColor;
    }
    if(clicked) {
      onClick.accept(id);
    }
  }
  
}
