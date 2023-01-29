// Jacob Desilets
// 1/18/23
// DA 140

color c1 = color(255, 0, 0);
color c2 = color(0, 0, 255);
color c_inter = c1;
color c_target = c2;
color last_c_inter = color(0, 0, 0);

int rect_x, rect_y;

final float RATE = 0.01;
final int SPEED = 10;
final int HSIZE = 750;
final int VSIZE = 500;
int HRECT = 25;
int VRECT = 25;

class PaintedRect {
  int xsize = 0;
  int ysize = 0;
  int x = 0;
  int y = 0;
  
  PaintedRect(int xp, int yp, int xs, int ys) {
    x = xp;
    y = yp;
    xsize = xs;
    ysize = ys;
  }
  
  void draw() {
    rect(x, y, xsize, ysize);
  }
}

ArrayList<PaintedRect> paint = new ArrayList<PaintedRect>();

void settings() {
  // Works here but not in setup???
  size(HSIZE, VSIZE);
}

void setup() {
  rect_x = (HSIZE / 2) - (HRECT / 2);
  rect_y = (VSIZE / 2) - (VRECT / 2);
}

void draw() {
  background(0, 0, 0);
  c_inter = lerpColor(c_inter, c_target, RATE);
  
  if(c_inter == last_c_inter) {
    if(c_target == c1) c_target = c2;
    else c_target = c1;
  }
  
  rect_x = mouseX - (HRECT / 2);
  rect_y = mouseY - (VRECT / 2);
  
  noStroke();
  fill(c_inter);
  
  text("LMB: Draw    RMB: Clear    Scroll Wheel: Change size", 10, 20);
  
  for(int i = 0; i < paint.size(); i++) {
    paint.get(i).draw();
  }
  
  rect(rect_x, rect_y, HRECT, VRECT);
  
  last_c_inter = c_inter;
}

void mouseDragged() {
  if(mouseButton == LEFT) {
      paint.add(new PaintedRect(mouseX - (HRECT / 2), mouseY - (VRECT / 2), HRECT, VRECT));
  }
}

void mousePressed() {
  if(mouseButton == LEFT) {
      paint.add(new PaintedRect(mouseX - (HRECT / 2), mouseY - (VRECT / 2), HRECT, VRECT));
  } else {
    paint.clear();
  }
}

void mouseWheel(MouseEvent e) {
  float v = e.getCount();
  if(v < 0) {
    HRECT -= 5;
    VRECT -= 5;
  } else {
    HRECT += 5;
    VRECT += 5;
  }
}
