class Point {
  float x, y, w, h;
  int c;
  
  Point(float x, float y, float w, float h, int c) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c = c;
  }
  
  void display() {
    noStroke();
    fill(c);
    ellipse(w, y, x, h);
  }
}
