Tile tile;

void setup() {
  size(1920, 1080);
  
  tile = new Tile("sprite1.png");
  tile.position = new PVector(width / 2, height / 2);
  tile.size = new PVector(200, 400);
}

void draw() {
  background(255);
  tile.drawTile();
}
