

class FlipButton {
  float x, y, w, h;
  int hue, group;
  boolean flipped;
  
  FlipButton(float x, float y, float w, float h, int group) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.group = group;
    
    hue = (int)random(256);
    
    flipped = false;
  }
  
  void display() {
    noStroke();
    if(flipped) {
      fill(0);
      rect(x, y, w, h);
      fill(255);
      textSize(50);
      text(group, x+50, y+50);
    } else {
      fill(hue, 255, 255);
      rect(x, y, w, h);
    }
  }
  
  boolean pointOver(float x, float y) {
    return ((x >= this.x && x <= this.x+w) && (y >= this.y && y <= this.y+h));
  }
}

class GameManager {
  int rows, cols, flipCount, flippedGroup, score;
  FlipButton[][] buttons;
  
  GameManager(int rows, int cols) {
    this.rows = rows;
    this.cols = cols;
    assert((rows*cols) % 2 == 0); // Must be an even number of buttons
    
    int groupIndex = 1;
    //int[] groups = new int[(rows * cols)];
    ArrayList<Integer> groups = new ArrayList<>();
    for(int i = 0; i < rows * cols; i += 2) {
      //groups[i] = groupIndex;
      //groups[i+1] = groupIndex;
      groups.add(groupIndex);
      groups.add(groupIndex);
      groupIndex++;
      
      flipCount = 0;
      flippedGroup = 0;
      score = 0;
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
  }
  
  void reset() {
    println("reset");
    flipCount = 0;
    flippedGroup = 0;
    
    for(int i = 0; i < rows; i++) {
      for(int j = 0; j < cols; j++) {
        buttons[i][j].flipped = false;
      }
    }
  }
  
  void mouseCheck(int mX, int mY) {
    
    for(int i = 0; i < rows; i++) {
      for(int j = 0; j < cols; j++) {
        if(buttons[i][j].pointOver(mX, mY)) {
          buttons[i][j].flipped = true;
          if(flipCount == 0) {
            flipCount += 1;
            flippedGroup = buttons[i][j].group;
          } else {
            if(buttons[i][j].group == flippedGroup) {
              score += 1;
              println("Score " + score);
            }
            display();
            stopUntil(1000);
            reset();
          }
          println(flipCount);
        }
      }
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
  
  void stopUntil(int millis) {
    last = millis();
    while(true) {
      now = millis();
      deltaTime = now - last;
      if(deltaTime > millis) { break; }
    }
    println("waited!");
  }
  
  
  
}
