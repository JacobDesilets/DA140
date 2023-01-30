// Base class for all moving game objects
// Provides acceleration based movement and screen wrapping
class Movable {
  boolean doWrap = true;
  PVector pos, vel, acc;
  float rot, friction, maxVel;
  boolean alive;
  float collisionRadius;
  
  Movable(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    
    rot = 0;
    friction = 0.99;
    maxVel = 50;
    alive = true;
    collisionRadius = 20;
  }
  
  void update() {
    if(doWrap) { wrap(); }
    vel.add(acc);
    vel.limit(maxVel);
    vel.mult(friction);
    pos.add(vel);
    
    acc.mult(0);
  }
  
  void applyForce(PVector force) {
    acc.add(force);
  }
  
  void wrap() {
    if (pos.x < -151) { pos.x = width; }
    if (pos.x > width + 151) { pos.x = 0; }
    if (pos.y < -151) { pos.y = height; }
    if (pos.y > height + 151) { pos.y = 0; }
  }
  
  boolean collisionCheck(float x, float y) {
    // for the sake of simplicity, just check the distance from the point to the center of the object
    if(dist(x, y, pos.x, pos.y) < collisionRadius) { return true; }
    return false;
  }
}

class GameManager {
  ArrayList<Asteroid> asteroids;
  Player p;
  
  int score;
  String gameState;
  
  final int MAX_ASTEROIDS = 15;
  
  GameManager(Player p) {
    asteroids = new ArrayList<Asteroid>();
    this.p = p;
    score = 0;
    
    gameState = "PLAYING";  // PLAYING or GAMEOVER
  }
  
  void spawn() {
    // 0: above screen
    // 1: right of screen
    // 2: below screen
    // 3: left of screen
    int spawnZone = (int)random(4);
    float spawnX = 0;
    float spawnY = 0;
    
    int offset = 100;
    
    switch(spawnZone) {
      case 0:
        spawnX = random(width);
        spawnY = -offset;
        break;
      case 1:
        spawnX = width + offset;
        spawnY = random(height);
        break;
      case 2:
        spawnX = random(width);
        spawnY = height + offset;
        break;
      case 3:
        spawnX = -offset;
        spawnY = random(height);
        break;
    }
    
    Asteroid a = new Asteroid(spawnX, spawnY, random(10, 31));
    PVector toCenter = new PVector(-(spawnX - width/2), -(spawnY - height/2)).setMag(random(1, 5));
    a.applyForce(toCenter);
    asteroids.add(a);
  }
  
  void manage() {
    draw();
    // Spawn new asteroid if applicable
    int count = asteroids.size();
    if(count < MAX_ASTEROIDS && randomChance(10)) {
      spawn();
    }
    
    // detect collisions and destroy asteroids
    for (int i = asteroids.size() - 1; i >= 0; i--) {
      Asteroid a = asteroids.get(i);
      for (Projectile proj : p.projectiles) {
        if(a.collisionCheck(proj.pos.x, proj.pos.y)) {
          asteroids.remove(i);
          score += 10;
        }
      }
    }
    
    // detect collision with player
    for (Asteroid a : asteroids) {
      if(a.collisionCheck(p.pos.x, p.pos.y)) {
        gameState = "GAMEOVER";
        println("GAMEOVER");
      }
    }
    
  }
  
  void draw() {
    for(Asteroid a : asteroids) {
      a.update();
      a.draw();
    }
  }
}

// Returns true if char array pi contains char i, false otherwise
boolean arrayContains(char[] pi, char i) {
  // Use linear search because pi will usually be small
  for (char c : pi) {
    if(c == i) {
      return true;
    }
  }
  return false;
}

// returns true if given int c is greater than random float r
boolean randomChance(int c) {
  float r = random(100);
  if(c > r) { return true; }
  return false;
}
