/**
 Made Cody Bolleboom
 05-10-2020 10:44
 */

class TileManager {
  ArrayList<TileGroup> tiles = new ArrayList<TileGroup>();
  float defaultGroupWidth = 1000;
  int speed = 5;
  int startingGroups = 2;

  JSONArray chunks;
  int chunkAmount;

  //Moves all the tiles. (Patrick Eikema)
  void move() {
    for (int i = 0; i < tiles.size(); i++) {
      tiles.get(i).position.x -= speed;
    }
  }

  TileManager() {
    chunks = loadJSONArray("json/chunks.json");
    chunkAmount = chunks.size();
    
    for (int i = 0; i < startingGroups; i++) {
      TileGroup newGroup = new TileGroup(new PVector(i * defaultGroupWidth, height - 50));
        newGroup.loadGroup((int)random(0, chunkAmount - 1));
        tiles.add(newGroup);
    }
  }

  void listener() {
    if (tiles.size() > 0) {
      TileGroup group = tiles.get(0);
      if (group.position.x < -defaultGroupWidth) {
        tiles.remove(0);
        
        TileGroup lastGroup = tiles.get(tiles.size() - 1);
        
        TileGroup newGroup = new TileGroup(new PVector(lastGroup.position.x + defaultGroupWidth, height - 50));
        newGroup.loadGroup((int)random(0, chunkAmount - 1));
        tiles.add(newGroup);
      }
    }
  }
}
