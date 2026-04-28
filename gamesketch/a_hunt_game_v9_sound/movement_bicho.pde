// movement bicho
float dt;        // time between frames in seconds
int lastTime;    // to calculate dt


class Bicho {
  float x, y;
  float t1, t2;
  float r = 20;
  color cbicho;
  PImage ibicho;

  boolean captured = false;
  boolean dead     = false;

  float noiseSpeed = 1.2;   // speed for bug movement

  Bicho() {
    x = random(width);
    y = random(height);
    t1 = random(1000);
    t2 = random(2000);
    cbicho = color(100, 200, 255);
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
