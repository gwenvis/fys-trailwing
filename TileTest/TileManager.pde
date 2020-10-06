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

  /**
   * @author Cody Bolleboom
   * 
   * load the chunks from json and create the minimal amount of the groups
   */
  TileManager(float movementSpeed) {
    speed = movementSpeed;

    //load chunks form json
    chunks = loadJSONArray("json/chunks.json");
    chunkAmount = chunks.size();

    //create the minimal amount of chunks
    for (int i = 0; i < startingGroups; i++) {
      //create a new chunk to the right of the most right chunk
      TileGroup newGroup = new TileGroup(new PVector(i * defaultGroupWidth, height - 100));
        //add the tile positions of a random chunk to the new chunk
        newGroup.loadGroup(chunks, (int)random(0, chunkAmount));
        //add the chunk to the manager list
        tileGroups.add(newGroup);
    }
  }

  //Moves all the tiles. (Patrick Eikema)
  void moveGroups() {
    for (int i = 0; i < tileGroups.size(); i++) {
      tileGroups.get(i).position.x -= speed;
    }
  }

  //Draw all the tiles. (Patrick Eikema)
  void drawGroups() {
    for (int i = 0; i < tileGroups.size(); i++) {
      tileGroups.get(i).drawGroup();
    }
  }

  /**
   * @author Cody Bolleboom
   * Check if a chunk is out of frame and delete it and create a new one
   *
   * @return void
   */
  void listener() {
    //check if there are any chunks loaded
    if (tileGroups.size() > 0) {

      //get the most left chunk
      TileGroup group = tileGroups.get(0);
      //check if the most left chunk is out of frame
      if (group.position.x < -defaultGroupWidth) {
        //delete the most left chunk
        tileGroups.remove(0);

        //get the most right chunk
        TileGroup lastGroup = tileGroups.get(tileGroups.size() - 1);

        //create a new chunk to the right of the most right chunk
        TileGroup newGroup = new TileGroup(new PVector(lastGroup.position.x + defaultGroupWidth, height - 100));
        //add the tile positions of a random chunk to the new chunk
        newGroup.loadGroup(chunks, (int)random(0, chunkAmount));
        //add the chunk to the manager list
        tileGroups.add(newGroup);
      }
    }
  }
}
