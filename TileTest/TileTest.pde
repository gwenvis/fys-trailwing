Tile[] tile = new Tile[10];
Tile tile2;
TileGroup group;

void setup() {
  size(1920, 1080);
    
  tile[0] = new Tile("placeholder_ground.png", new PVector(400, 100), new PVector(0, 0));
  tile[1] = new Tile("placeholder_ground.png", new PVector(400, 100), new PVector(600, 0));
  tile[2] = new Tile("placeholder_ground.png", new PVector(1000, 100), new PVector(0, -600));
  
  group = new TileGroup(new PVector(0, height - 100));
  group.tiles.add(tile[0]);
  group.tiles.add(tile[1]);
  group.tiles.add(tile[2]);
}

void draw() {
  background(255);
  group.drawGroup();
}
