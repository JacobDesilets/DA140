import processing.sound.*;
SoundFile music;
BeatDetector beat;

float r, z;

PShape cube;

ArrayList<Cube> cubes;

Amplitude amp;

int steps, interval;


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
  
  cube = createShape(BOX, 100);
  cubes = new ArrayList<Cube>();
  
  steps = 5;
  interval = width/5;
}

void draw() {
  background(0);
  if(beat.isBeat()) {
    cubes.add(new Cube((int)random(6) * interval, (int)random(6) * interval, interval/2, amp.analyze()*10000));
  }
  
  for(int i = cubes.size()-1; i >= 0; i--) {
    Cube c = cubes.get(i);
    if(!c.alive) { cubes.remove(c); continue; }
    c.update();
    c.display();
  }
}
