// class to manage the movements of the characters (bugs or bichos)
// The movements were copied from an example found that moved circles in a way 
// that seemed like bugs flying. 

float dt;        // time between frames in seconds
int lastTime;    // to calculate dt


class Bicho {
  float x, y;
  float t1, t2;
  float r = 20;
  PImage ibicho;

  boolean captured = false;
  boolean dead     = false;

  float noiseSpeed = 0.2;   // speed for bug movement
                            // 0.2 is very slow for easy catching. 1 is fast and difficult

  Bicho() {
    x = random(width);
    y = random(height);
    t1 = random(1000);
    t2 = random(2000);
    captured = false;
    dead = false;
  }

  void update() {
    if (captured) return;  // no se mueve si está capturado

    t1 += noiseSpeed * dt;
    t2 += noiseSpeed * dt;

    x = map(noise(t1), 0, 1, -width*0.3, width*1.3);
    y = map(noise(t2), 0, 1, -height*0.3, height*1.3);

   if (x > width || x < 0 || y > height || y < 0) {
      dead = true;
    }
  }

  void display() {
    image(ibicho, x, y, r*2, r*2);
  }

  boolean isCaptured() {
    return dist(mouseX, mouseY, x, y) < r;
  }
}
