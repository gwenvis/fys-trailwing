float diameter = 50;
float offset = 25;

float boardWidth = 10;
float boardHeight = 9;

void setup() {
  size(500, 450);
}

void draw() {
  background(255);

  for (int y = 0; y < boardHeight; y++) {
    for (int x = 0; x < boardWidth; x++) {
      if (y > 5) {
        fill(0, 0, (255 / boardWidth) * x);
      } else if (y > 2 && y < 6) {
        fill(0, (255 / boardWidth) * x, 0); 
      } else {
       fill((255 / boardWidth) * x, 0, 0); 
      }
      ellipse(offset + x * diameter, offset + y * diameter, diameter, diameter);
    }
  }
}
