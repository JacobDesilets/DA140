import processing.sound.*;
SoundFile music;
BeatDetector beat;

float r;

PImage texture;
PShape ball;

int hue;

Amplitude amp;


void setup() {
  colorMode(HSB);
  size(500, 500, P3D);
  background(0);
  music = new SoundFile(this, "Space Jazz.mp3");
  music.loop();
  
  beat = new BeatDetector(this);
  beat.sensitivity(1);
  beat.input(music);
  
  amp = new Amplitude(this);
  amp.input(music);
  
  noFill();
  noStroke();
  
  texture = loadImage("world.jpg");
  ball = createShape(SPHERE, 100);
  ball.setTexture(texture);
  
  hue = 0;
  r = 0.01;
}

void draw() {
  background(hue % 255, 255, 255);
  
  directionalLight(255, 0, 255, -1, -1, -1);
  
  
  translate(width/2, height/2, 0);
  rotateX(r);
  rotateY(r);
  //rotateZ(r);
  
  if(beat.isBeat()) {
    hue += 5;
  } else {
    hue += 1;
  }
  
  r += 0.01;
  
  ball.translate(0, 0, amp.analyze());
  shape(ball);
}
