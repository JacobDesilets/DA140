// Base class for all moving game objects
// Provides acceleration based movement and screen wrapping
class Movable {
  boolean doWrap = true;
  PVector pos, vel, acc;
  float rot, friction, maxVel;
  float collisionRadius;

  Movable(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);

    rot = 0;
    friction = 0.99;
    maxVel = 50;
    collisionRadius = 20;
  }

  void update() {
    if (doWrap) {
      wrap();
    }
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
    if (pos.x < -151) {
      pos.x = width;
    }
    if (pos.x > width + 151) {
      pos.x = 0;
    }
    if (pos.y < -151) {
      pos.y = height;
    }
    if (pos.y > height + 151) {
      pos.y = 0;
    }
  }

  boolean collisionCheck(Movable m) {
    // for the sake of simplicity, just check the distance from the point to the center of the object
    if (dist(m.pos.x, m.pos.y, pos.x, pos.y) < (collisionRadius + m.collisionRadius)) {
      return true;
    }
    return false;
  }
  
  void reset() {
    pos = new PVector(width/2, height/2);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);

    rot = 0;
  }
}

// Handles spawning and destruction of asteroids, collisions, score, and creating particles where appropriate
class GameManager {
  ArrayList<Asteroid> asteroids;
  Player p;
  PShape[] asteroidShapes;
  ParticleSystem ps;

  int score;
  String gameState;

  // The max asteroids that can exist at once
  final int MAX_ASTEROIDS = 12;

  GameManager(Player p, PShape[] asteroidShapes, ParticleSystem ps) {
    asteroids = new ArrayList<Asteroid>();
    this.p = p;
    this.asteroidShapes = asteroidShapes;
    this.ps = ps;
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

    // how far offscreen asteroids are spawned
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

    int shapeIndex = (int)random(3);

    Asteroid a = new Asteroid(spawnX, spawnY, random(10, 31), asteroidShapes[shapeIndex]);
    PVector toPlayer = new PVector(-(spawnX - p.pos.x), -(spawnY - p.pos.y)).setMag(random(1, 5));
    a.applyForce(toPlayer);
    asteroids.add(a);
  }

  // main loop for this class, everything gets done here
  void manage() {
    draw();

    // Stop here if game over
    if (gameState.equals("GAMEOVER")) {
      return;
    }
    // Spawn new asteroid if applicable
    int count = asteroids.size();
    if (gameState.equals("PLAYING")) {
      if (count < MAX_ASTEROIDS && randomChance(10)) {
        spawn();
      }
    }

    // detect collisions and destroy asteroids
    for (int i = asteroids.size() - 1; i >= 0; i--) {
      Asteroid a = asteroids.get(i);
      for (Projectile proj : p.projectiles) {
        if (a.collisionCheck(proj)) {
          asteroids.remove(i);
          ps.createParticles(a.pos.x, a.pos.y, (int)random(5, 10));
          score += 10;
        }
      }
    }

    // detect collision with player
    for (Asteroid a : asteroids) {
      if (a.collisionCheck(p)) {
        ps.createParticles(p.pos.x, p.pos.y, (int)random(50, 100));
        gameState = "GAMEOVER";
      }
    }
  }
  
  // reset for new game
  void reset() {
    asteroids.clear();
  }

  // render each asteroid
  void draw() {
    for (Asteroid a : asteroids) {
      a.update();
      a.draw();
    }
  }
}

// Returns true if char array pi contains char i, false otherwise
boolean arrayContains(char[] pi, char i) {
  // Use linear search because pi will usually be small
  for (char c : pi) {
    if (c == i) {
      return true;
    }
  }
  return false;
}

// returns true if given int c is greater than random float r
boolean randomChance(int c) {
  float r = random(100);
  if (c > r) {
    return true;
  }
  return false;
}
