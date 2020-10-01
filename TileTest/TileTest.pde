Tile[] tiled = new Tile[10];
Tile tile2;
TileGroup[] groups = new TileGroup[2];

void setup() {
  size(1920, 1080);
  
  groups[0] = new TileGroup(new PVector(0, height - 100));
  groups[0].loadGroup(0);
  
  groups[1] = new TileGroup(new PVector(1000, height - 100));
  groups[1].loadGroup(1);
  
  /*JSONArray arr = json.getJSONArray("arr");
  JSONObject test = arr.getJSONObject(1);
  print(test.get("test"));*/
}

void draw() {
  background(255);
  groups[0].position.x -= 1;
  groups[0].drawGroup();
  
  groups[1].position.x -= 1;
  groups[1].drawGroup();
}
