import java.util.Collections;

PImage img;
int interval;


ArrayList<Point> points;

float scale = 20;

void settings() {
  img = loadImage("dog.jpg");
  size(img.width, img.height);
  
}

void setup() {
  frameRate(120);
  background(255);
  noStroke();
  interval = 10;
  
  img.filter(DILATE);
  img.filter(POSTERIZE, 16);
  
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
  
  Collections.shuffle(points);
}

void mouseWheel(MouseEvent event) {
  println(interval);
  float e = event.getCount();
  if(e > 0 && interval > 1) { interval -= 1; }
  else if (e < 0) { interval += 1; }
}

void draw() {
  scale = lerp(scale, 0.5, 0.001);
  
  int r = (int)random(points.size());
  points.get(r).display(scale);
  
}
