import processing.sound.*;
SoundFile music;
BeatDetector beat;


PImage texture;
PShape ball;

ArrayList<Ball> balls;

Amplitude amp;

int id = 0;
int ballcount = 0;
int maxballs = 15;

void setup() {
  colorMode(HSB);
  size(500, 500, P3D);
  background(0);
  music = new SoundFile(this, "The Entertainer.mp3");
  music.loop();
  
  beat = new BeatDetector(this);
  beat.sensitivity(100);
  beat.input(music);
  
  amp = new Amplitude(this);
  amp.input(music);
  
  
  texture = loadImage("jacob.jpg");
  ball = createShape(SPHERE, 25);
  ball.setTexture(texture);
  
  balls = new ArrayList<Ball>();
}

void draw() {
  background(0);
  
  ball.rotateX(0.1);
  ball.rotateZ(0.1);
  ball.setStroke(color((int)(amp.analyze() * 255), 255, 255));
  
  directionalLight(255, 0, 255, -0.5, -1, -1);
  ambientLight(102, 102, 102);
  
  for(int i = balls.size()-1; i >= 0; i--) {
    Ball b = balls.get(i);
    b.update(balls);
    //b.randomForce(amp.analyze() * 100);
    b.display();
  }
  
  if(beat.isBeat() && ballcount < maxballs) {
    balls.add(new Ball(random(width), random(height), 50, id));
    id += 1;
    ballcount++;
    
    for(int i = balls.size()-1; i >= 0; i--) {
      Ball b = balls.get(i);
      if(!b.alive) { balls.remove(b); ballcount--; continue; }
  }
}
}
