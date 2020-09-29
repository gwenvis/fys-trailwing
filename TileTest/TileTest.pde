Tile tile;
Tile tile2;
TileGroup group;

void setup() {
  size(1920, 1080);
    
  tile = new Tile("sprite1.png", new PVector(32, 32), new PVector(0, 0));
  tile2 = new Tile("sprite1.png", new PVector(32, 32), new PVector(64, 0));
  
  group = new TileGroup(new PVector(width / 2, height / 2));
  group.tiles.add(tile);
  group.tiles.add(tile2);
}

void draw() {
  background(255);
  group.drawGroup();
}
