/**
 Made Cody Bolleboom
 05-10-2020 10:44
 */

class TileManager {
  ArrayList<TileGroup> tileGroups = new ArrayList<TileGroup>();
  float defaultGroupWidth = Config.DEFAULT_GROUP_WIDTH;
  float speed;
  int startingGroups = Config.MIN_STARTING_CHUNKS;
  float bottomOffset = Config.CHUNK_BOTTOM_OFFSET;

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
      TileGroup newGroup = new TileGroup(new PVector(i * defaultGroupWidth, height - bottomOffset));
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
   * Checks the collision and returns the collision direction as a boolean
   *
   * @return void
   */
  TileCollision checkCollision(PVector targetPosition, PVector targetSize) {
    for (TileGroup tileGroup : tileGroups) {
      for (Tile tile : tileGroup.tiles) {
        PVector tilePosition = new PVector(tileGroup.position.x + tile.position.x, tileGroup.position.y + tile.position.y);

        boolean top = tilePosition.y + tile.size.y / 2 >= targetPosition.y - targetSize.y / 2 && tilePosition.y - tile.size.y / 2 - 1 <= targetPosition.y - targetSize.y / 2;
        boolean bottom = tilePosition.y + tile.size.y / 2 >= targetPosition.y + targetSize.y / 2 && tilePosition.y - tile.size.y / 2  <= targetPosition.y + targetSize.y / 2;

        boolean left = tilePosition.x + tile.size.x / 2 >= targetPosition.x - targetSize.x / 2 && tilePosition.x - tile.size.x / 2 <= targetPosition.x - targetSize.x / 2;
        boolean right = tilePosition.x + tile.size.x / 2 >= targetPosition.x + targetSize.x / 2 && tilePosition.x - tile.size.x / 2 <= targetPosition.x + targetSize.x / 2;

        if ((top && left) || (top && right) || (bottom && left) || bottom && right) {

          PVector collision = new PVector((right ? 1 : (left ? -1 : 0)), (top ? 1 : (bottom ? -1 : 0)));

          if (tilePosition.y - tile.size.y / 2 ==  targetPosition.y + targetSize.y / 2 || tilePosition.y + tile.size.y / 2 ==  targetPosition.y - targetSize.y / 2) {
            collision.x = 0;
          }
          
          TileCollision col = new TileCollision();
          col.direction = collision;
          col.position = new PVector(tilePosition.x + tile.size.x * collision.x, tilePosition.y + tile.size.y * collision.y);

          return col;
        }
      }
    }

    return new TileCollision();
  }

  /**
   * @author Cody Bolleboom
   * Checks the collision and returns the collision direction as a boolean
   *
   * @return void
   */
  Obstacle ObstacleCheckCollision(PVector targetPosition, PVector targetSize) {
    for (TileGroup tileGroup : tileGroups) {
      for (Obstacle obstacle : tileGroup.obstacles) {
        PVector tilePosition = new PVector(tileGroup.position.x + obstacle.position.x, tileGroup.position.y + obstacle.position.y);

        boolean top = tilePosition.y + obstacle.size.y / 2 >= targetPosition.y - targetSize.y / 2 && tilePosition.y - obstacle.size.y / 2 - 1 <= targetPosition.y - targetSize.y / 2;
        boolean bottom = tilePosition.y + obstacle.size.y / 2 >= targetPosition.y + targetSize.y / 2 && tilePosition.y - obstacle.size.y / 2  <= targetPosition.y + targetSize.y / 2;

        boolean left = tilePosition.x + obstacle.size.x / 2 >= targetPosition.x - targetSize.x / 2 && tilePosition.x - obstacle.size.x / 2 <= targetPosition.x - targetSize.x / 2;
        boolean right = tilePosition.x + obstacle.size.x / 2 >= targetPosition.x + targetSize.x / 2 && tilePosition.x - obstacle.size.x / 2 <= targetPosition.x + targetSize.x / 2;

        if ((top && left) || (top && right) || (bottom && left) || bottom && right) {

          PVector collision = new PVector((right ? 1 : (left ? -1 : 0)), (top ? 1 : (bottom ? -1 : 0)));

          if (tilePosition.y - obstacle.size.y / 2 ==  targetPosition.y + targetSize.y / 2 || tilePosition.y + obstacle.size.y / 2 ==  targetPosition.y - targetSize.y / 2) {
            collision.x = 0;
          }

          return obstacle;
        }
      }
    }

    return null;
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
        TileGroup newGroup = new TileGroup(new PVector(lastGroup.position.x + defaultGroupWidth, height - bottomOffset));
        //add the tile positions of a random chunk to the new chunk
        newGroup.loadGroup(chunks, (int)random(0, chunkAmount));
        //add the chunk to the manager list
        tileGroups.add(newGroup);
      }
    }
  }
}

class TileCollision {
  PVector direction = new PVector();
  PVector position;
}
