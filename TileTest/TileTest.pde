/*Tile[] tiled = new Tile[10];
Tile tile2;
TileGroup[] groups = new TileGroup[2];*/

TileManager manager;

void setup() {
  size(1920, 1080);
  
  manager = new TileManager(10);
}

void draw() {
  background(255);
  
  manager.listener();
  manager.moveGroups();
  manager.drawGroups();
}
