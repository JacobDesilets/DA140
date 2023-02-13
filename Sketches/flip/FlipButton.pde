

class FlipButton {
  float x, y, w, h;
  int hue, group;
  boolean flipped;
  boolean matched = false;
  long timer;
  int dur;
  boolean timerSet = false;
  
  FlipButton(float x, float y, float w, float h, int group) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.group = group;
    
    hue = (int)random(256);
    
    flipped = false;
    timer = 0;
    dur = -1;
  }
  
  void display() {
    noStroke();
    if(flipped) {
      fill(0);
      if(matched) { fill(#6F6F6F); }
      rect(x, y, w, h);
      fill(255);
      if(matched) { fill(#69C177); }
      textSize(h/2);
      text(group, x+(w/2), y+(h/2));
    } else {
      if(checkTimer()) {
        fill(hue, 255, 255);
        rect(x, y, w, h);
      }
    }
  }
    
    void setTimer(int dur) {
      println("Set timer for button at " + x + " " + y);
      timer = millis();
      this.dur = dur;
      timerSet = true;
    }
    
    boolean checkTimer() {
      if(!timerSet) { return true; }
      if(millis() - timer >= dur) {
        timer = 0;
        dur = -1;
        flipped = false;
        println("Timer ran out!");
        timerSet = false;
        return true;
      }
      return false;
    }
  
  boolean pointOver(float x, float y) {
    return ((x >= this.x && x <= this.x+w) && (y >= this.y && y <= this.y+h));
  }
}

class GameManager {
  int rows, cols, score, flippedGroup;
  long timer;
  FlipButton[][] buttons;
  ArrayList<FlipButton> flippedButtons;
  int DELAY_FLIP = 1000; // how long to wait to flip back on wrong answer
  
  GameManager(int rows, int cols) {
    this.rows = rows;
    this.cols = cols;
    assert((rows*cols) % 2 == 0); // Must be an even number of buttons
    
    int groupIndex = 1;
    ArrayList<Integer> groups = new ArrayList<>();
    for(int i = 0; i < rows * cols; i += 2) {
      groups.add(groupIndex);
      groups.add(groupIndex);
      groupIndex++;
      
      
    }
    
    Collections.shuffle(groups);
    
    float xInterval = width/rows;
    float yInterval = height/cols;
    
    groupIndex = 0;
    buttons = new FlipButton[rows][cols];
    for(int i = 0; i < rows; i++) {
      for(int j = 0; j < cols; j++) {
        buttons[i][j] = new FlipButton(xInterval*i, yInterval*j, xInterval, yInterval, groups.get(groupIndex));
        groupIndex++;
      }
    }
    flippedGroup = 0;
    score = (rows * cols) * 3;
    flippedButtons = new ArrayList<FlipButton>();
    
    timer = millis();
  }
  
  void mouseCheck(int mX, int mY) {
    for(int i = 0; i < rows; i++) {
      for(int j = 0; j < cols; j++) {
        if(buttons[i][j].pointOver(mX, mY) && buttons[i][j].flipped == false) {
          flip(buttons[i][j]);
        }
      }
    }
  }
  
  void flip(FlipButton button) {
    score--;
    int flippedCount = flippedButtons.size();
    if(flippedCount == 0) {
      flippedGroup = button.group;
      flippedButtons.add(button);
      button.flipped = true;
    } else if(button.group == flippedGroup) {
      flippedButtons.add(button);
      button.flipped = true;
      for(FlipButton b : flippedButtons) {
        b.matched = true;
      }
      flippedButtons.clear();
    } else {
      flippedButtons.add(button);
      button.flipped = true;
      button.display();
      for(FlipButton b : flippedButtons) {
        b.flipped = false;
        b.setTimer(DELAY_FLIP);
      }
      flippedButtons.clear();
    }
  }
  
  void display() {
    // Draw buttons
    for(int i = 0; i < rows; i++) {
      for(int j = 0; j < cols; j++) {
        buttons[i][j].display();
      }
    }
  }
}
