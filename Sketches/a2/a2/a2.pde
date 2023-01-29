// Jacob Desilets
// DA 140
// 1/19/23


int STEPS;
int INCREMENT;
int c1, c2 = color(10, 10, 10);

void setup() {
  size(500, 500);
  STEPS = 5;
  INCREMENT = width / STEPS;
  frameRate(5);
}

void draw() {
  strokeWeight(3);
  //oStroke();
  boolean s = false;
  for (int i = 0; i <= width; i += INCREMENT) {
    for (int j = 0; j <= height; j += INCREMENT) {
      c1 = color((red(c1) + i)%255, (green(c1) + j)%255, (blue(c1) + i+j)%255);
      c2 = color((red(c2) + i)%255, (green(c2) + j)%255, (blue(c2) + i+j)%255);
      tri(c1, i, j, INCREMENT, s);
      tri(c2, i, j, INCREMENT, !s);
      s = !s;
    }
  }
  
}

void tri(int c, int rx, int ry, int side_len, boolean upwards) {
  fill(c);
  
  int x1 = rx;
  int y1 = ry;
  int x2, y2, x3, y3;
  if(upwards) {
    x2 = x1;
    y2 = y1 - side_len;
    x3 = x1 + side_len;
    y3 = y1;
  } else {
    x1 += side_len;
    y1 -= side_len;
    x2 = x1;
    y2 = y1 + side_len;
    x3 = x1 - side_len;
    y3 = y1;
  }
  triangle(x1, y1, x2, y2, x3, y3);
  float r = (red(c) + 50) % 255;
  float g = (green(c) + 50) % 255;
  float b = (blue(c) + 50) % 255;
  fill(color(r, g, b));
  triangle((x1 + (side_len / 2)), (y1 + (side_len / 2)), (x2 + (side_len / 2)), (y2 + (side_len / 2)), (x3 + (side_len / 2)), (y3 + (side_len / 2)));
  r = (r + 50) % 255;
  g = (g + 50) % 255;
  b = (b + 50) % 255;
  fill(color(r, g, b));
  triangle((x1 + (side_len / 1.4)), (y1 + (side_len / 1.4)), (x2 + (side_len / 1.4)), (y2 + (side_len / 1.4)), (x3 + (side_len / 1.4)), (y3 + (side_len / 1.4)));
}

void mouseWheel(MouseEvent e) {
  float v = e.getCount();
  if(v < 0) {
    if(STEPS > 1) {
      STEPS -= 1;
    }
  } else {
    STEPS += 1;
  }
  INCREMENT = width / STEPS;
}
