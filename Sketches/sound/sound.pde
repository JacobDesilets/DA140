import processing.sound.*;
SoundFile music;
BeatDetector beat;

float r, z;

PImage texture;
PShape ball;

int hue, mult;

Amplitude amp;


void setup() {
  colorMode(HSB);
  size(500, 500, P3D);
  background(0);
  music = new SoundFile(this, "Aggressor.mp3");
  music.loop();
  
  beat = new BeatDetector(this);
  beat.sensitivity(1);
  beat.input(music);
  
  amp = new Amplitude(this);
  amp.input(music);
  
  noFill();
  noStroke();
  
  texture = loadImage("jacob.jpg");
  ball = createShape(SPHERE, 100);
  ball.setTexture(texture);
  
  hue = 0;
  r = 0.01;
  z = 0;
  mult = 1;
}

void draw() {
  background(hue % 255, 255, 255);
  
  directionalLight(255, 0, 255, -0.5, -1, -1);
  
  if(z >= 60) { mult = -1; }
  else if(z <= -60) {mult = 1; }
  float move;
  if(amp.analyze() >= 0.45) { move = 3; }
  else { move = 0.1; }
  translate(width/2, height/2, z += move * mult);
  
  ball.rotateX(r);
  ball.rotateY(r);
  ball.rotateZ(r);
  
  if(beat.isBeat()) {
    hue += 20;
  } else {
    hue += 1;
  }
   
  shape(ball);
}
