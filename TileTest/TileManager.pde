/**
 Made Cody Bolleboom
 05-10-2020 10:44
 */

class TileManager {
  ArrayList<TileGroup> tileGroups = new ArrayList<TileGroup>();
  float defaultGroupWidth = 1000;
  float speed;
  int startingGroups = 3;

  JSONArray chunks;
  int chunkAmount;

  //Moves all the tiles. (Patrick Eikema)
  void moveGroups() {
    for (int i = 0; i < tileGroups.size(); i++) {
      tileGroups.get(i).position.x -= speed;
    }
  }

  void drawGroups() {
    for (int i = 0; i < tileGroups.size(); i++) {
      tileGroups.get(i).drawGroup();
    }
  }

  TileManager(float movementSpeed) {
    speed = movementSpeed;
    
    chunks = loadJSONArray("json/chunks.json");
    chunkAmount = chunks.size();

    for (int i = 0; i < startingGroups; i++) {
      TileGroup newGroup = new TileGroup(new PVector(i * defaultGroupWidth, height - 100));
      newGroup.loadGroup((int)random(0, chunkAmount));
      tileGroups.add(newGroup);
    }
  }

  void listener() {
    if (tileGroups.size() > 0) {

      TileGroup group = tileGroups.get(0);
      if (group.position.x < -defaultGroupWidth) {
        tileGroups.remove(0);

        TileGroup lastGroup = tileGroups.get(tileGroups.size() - 1);

        TileGroup newGroup = new TileGroup(new PVector(lastGroup.position.x + defaultGroupWidth, height - 100));
        newGroup.loadGroup((int)random(0, chunkAmount));
        tileGroups.add(newGroup);
      }
    }
  }
}
