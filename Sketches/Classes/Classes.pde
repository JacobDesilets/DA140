// Jacob Desilets
// 2/8/23
// DA 140
//
// Usage:
// space:   new ball
// r:       apply random force to all balls
// c:       delete all balls

ArrayList<Ball> balls;

long currentTime, startTime, deltaTime;

int ballID = 0;

Ball selected;

void setup() {
  colorMode(HSB);
  size(500, 500);
  balls = new ArrayList<Ball>();
  
  // start with 5 balls
  for(int i = 0; i < 5; i++) {
    addBall();
  }
  
  startTime = 0;
  selected = null;
}

void draw() {
  currentTime = System.nanoTime();
  deltaTime = (currentTime - startTime) / 1_000_000_000;
  startTime = currentTime;
  
  background(0);
  
  for(Ball b : balls) {
    b.update(balls);
    b.display();
  }
  
  if(selected != null) {
    PVector toMouse = new PVector(mouseX, mouseY).sub(selected.pos).setMag(10);
    selected.applyForce(toMouse);
  }
}

void keyReleased() {
  switch(key) {
    case ' ':
      addBall();
      break;
    case 'r':
      for(Ball b : balls) {
        b.randomForce(500);
      }
      break;
    case 'c':
      balls.clear();
      break;
  }
}

void mousePressed() {
  if(mouseButton==LEFT) {
    for(Ball b : balls) {
      if(b.mouseOver(mouseX, mouseY)) {
        selected = b;
      }
    }
  }
}

void addBall() {
  balls.add(new Ball(random(10, width-9), random(height/3), random(10, 50), ballID));
  ballID++;
}
