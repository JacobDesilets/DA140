ArrayList<Ball> balls;

long currentTime, startTime, deltaTime;

int ballID = 0;

void setup() {
  colorMode(HSB);
  size(500, 500);
  balls = new ArrayList<Ball>();
  
  startTime = 0;
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
}

void keyReleased() {
  switch(key) {
    case ' ':
      
      balls.add(new Ball(random(10, width-9), random(height/3), random(10, 30), ballID));
      ballID++;
      break;
  }
}
