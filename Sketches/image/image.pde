PImage img;
int interval;

ArrayList<Point> points;

int timer;

void settings() {
  img = loadImage("dog.jpg");
  size(img.width, img.height);
}

void setup() {
  background(255);
  noStroke();
  interval = 10;
  
  points = new ArrayList<Point>();
  
  for(int x = 0; x < img.width; x += interval) {
    for(int y = 0; y < img.height; y += interval) {
      int c = img.get(x, y);
      float b = brightness(c);
      b /= 255;
      b = constrain(b, 1/interval, interval);
      
      
      points.add(new Point(x, y, interval, interval, c));
    }
  }
  
  timer = millis();
}

void mouseWheel(MouseEvent event) {
  println(interval);
  float e = event.getCount();
  if(e > 0 && interval > 1) { interval -= 1; }
  else if (e < 0) { interval += 1; }
}

void draw() {
  background(255);
  
  
}

boolean checkTimer(int duration) {
  int dt = millis() - timer;
  
}
