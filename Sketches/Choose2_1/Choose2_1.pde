/*
Jacob Desilets
1/25/23
DA140

Single circle falls from the top of the screen to the bottom.
Every time this repeats, the circle falls from a new starting X position. 
And if the user accurately clicks the circle, then the circle color will change.
*/

final double G = 9.8;
Circle c;
int score = 0;

void setup() {
  size(500, 750);
  noStroke();
  colorMode(HSB);
  
  c = new Circle(50);
}

void draw() {
  background(255);
  c.draw();
  c.update();
  fill(0);
  text("Score: " + score, 10, 10);
}

void mousePressed() {
  if(c.clickCheck(mouseX, mouseY)) {
    score++;
  }
}

class Circle {
  int x, y, r;
  int c;
  long startTime, lifeTime;
  double lifeTimeSeconds;
  
  Circle(int r) {
    this.r = r;
    reset();
  }
  
  void draw() {
    fill(c);
    ellipse(x, y, r, r);
  }
  
  void update() {
    long currentTime = System.nanoTime();
    lifeTime = currentTime - startTime;
    lifeTimeSeconds = (double) lifeTime / 1000000000;  // Nano seconds to seconds conversion
    y += G * lifeTimeSeconds;
    
    if(y > (height + r)) {  // Reset when ball falls off screen
      reset();
    }
  }
  
  void reset() {
    y = -r;
    x = int(random(0, width+1));
    lifeTime = 0;
    lifeTimeSeconds = 0;
    startTime = System.nanoTime();
  }
  
  boolean clickCheck(int mX, int mY) {
    // If the distance between the mouse and the center of the circle is
    // less than the radius, the circle contains the mouse
    double dist = distanceBetweenPoints(mX, mY, x, y);
    if(dist <= r) {
      c = color(random(0, 256), 255, 255);
      return true;
    }
    return false;
  }
}

double distanceBetweenPoints(int x1, int y1, int x2, int y2) {
  // to find distance between points A(x1, y1) and B(x2, y2), imagine a point C(x1, y2) and find the hypotenuse of the triangle
  // AB^2 = AC^2 + CB^2
  double ac = abs(y1 - y2);
  double cb = abs(x1 - x2);
  return Math.sqrt(Math.pow(ac, 2) + Math.pow(cb, 2));
}
