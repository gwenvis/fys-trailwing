/**
 Made by Cody Bolleboom
 05-10-2020 10:44
 */

class TileManager {
  float score;
  ArrayList<TileGroup> tileGroups = new ArrayList<TileGroup>();
  JSONArray chunkPool;

  ArrayList<JSONObject> usePool = new ArrayList<JSONObject>();
  ArrayList<JSONObject> difficultyPool = new ArrayList<JSONObject>();
  int chunkpool = 0;
  float defaultGroupWidth = Config.DEFAULT_GROUP_WIDTH;
  float speed;
  float speedCap;
  int startingGroups = Config.MIN_STARTING_CHUNKS;
  float bottomOffset = Config.CHUNK_BOTTOM_OFFSET;

  float poolDistance = 0;

  ArrayList<JSONArray> chunks = new ArrayList<JSONArray>();
  int chunkAmount;

  /**
   * @author Cody Bolleboom
   * 
   * load the chunks from json and create the minimal amount of the groups
   */
  TileManager(float movementSpeed) {    
    speed = movementSpeed;

    chunkPool = loadJSONArray("json/chunks.json");
    //load chunks form json

    for (int i = 0; i < startingGroups; i++) {
      //create a new chunk to the right of the most right chunk
      TileGroup newGroup = new TileGroup(new PVector(i * defaultGroupWidth, height - bottomOffset));
      //add the tile positions of a random chunk to the new chunk
      newGroup.loadGroup(chunkPool.getJSONArray(chunkpool).getJSONObject(i));
      //add the chunk to the manager list
      tileGroups.add(newGroup);
    }

    usePool = new ArrayList<JSONObject>();
    difficultyPool = new ArrayList<JSONObject>();
    for (int i = 0; i < chunkPool.getJSONArray(chunkpool).size(); i++) {
      if ((float)chunkPool.getJSONArray(chunkpool).getJSONObject(i).getFloat("start") != 0) {
        difficultyPool.add(chunkPool.getJSONArray(chunkpool).getJSONObject(i));
      } else {
        usePool.add(chunkPool.getJSONArray(chunkpool).getJSONObject(i));
      }
    }
    //exit();
  }

  /*
  * @author Cody
  * move tile with the player speed
  */
  void moveGroups() {
    for (int i = 0; i < tileGroups.size(); i++) {
      tileGroups.get(i).position.x -= speed;
    }

    //add distance to score and to distance travled on this elivation
    score += speed / frameRate;
    poolDistance += speed / frameRate;
  }

  /*
  * @author Cody
  * draw tiles on new position
  */
  void drawGroups() {
    for (int i = 0; i < tileGroups.size(); i++) {
      tileGroups.get(i).drawGroup();
    }
  }

  /**
   * @author Cody Bolleboom
   * Checks the collision and returns the collision direction as a boolean
   * collison in this context are the tiles the player can walk on
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

          PVector collision = new PVector((right ? Config.RIGHT : (left ? Config.LEFT : 0)), (top ? Config.UP : (bottom ? Config.DOWN : 0)));

          if (tilePosition.y - tile.size.y / 2 ==  targetPosition.y + targetSize.y / 2 || tilePosition.y + tile.size.y / 2 ==  targetPosition.y - targetSize.y / 2) {
            collision.x = 0;
          }

          TileCollision col = new TileCollision();
          col.direction = collision;
          col.position = new PVector(tilePosition.x + tile.size.x * collision.x, tilePosition.y + ((tile.size.y/2+targetSize.y/2) * collision.y));

          return col;
        }
      }
    }

    return new TileCollision();
  }

  /**
   * @author Cody Bolleboom
   * Checks the collision of obstacles and returns the collision direction as a boolean
   * Collision exists in layers and the layers say what type of collision it is for example: obstacle, coin and shield
   *
   * @return void
   */
  Obstacle ObstacleCheckCollision(PVector targetPosition, PVector targetSize) {
    for (TileGroup tileGroup : tileGroups) {

      int i = 0;
      for (Obstacle obstacle : tileGroup.obstacles) {
        PVector tilePosition = new PVector(tileGroup.position.x + obstacle.position.x, tileGroup.position.y + obstacle.position.y);

        boolean top = tilePosition.y + obstacle.size.y / 2 >= targetPosition.y - targetSize.y / 2 && tilePosition.y - obstacle.size.y / 2 - 1 <= targetPosition.y - targetSize.y / 2;
        boolean bottom = tilePosition.y + obstacle.size.y / 2 >= targetPosition.y + targetSize.y / 2 && tilePosition.y - obstacle.size.y / 2  <= targetPosition.y + targetSize.y / 2;

        boolean left = tilePosition.x + obstacle.size.x / 2 >= targetPosition.x - targetSize.x / 2 && tilePosition.x - obstacle.size.x / 2 <= targetPosition.x - targetSize.x / 2;
        boolean right = tilePosition.x + obstacle.size.x / 2 >= targetPosition.x + targetSize.x / 2 && tilePosition.x - obstacle.size.x / 2 <= targetPosition.x + targetSize.x / 2;

        if ((top && left) || (top && right) || (bottom && left) || bottom && right) {

          PVector collision = new PVector((right ? Config.RIGHT : (left ? Config.LEFT : 0)), (top ? Config.UP : (bottom ? Config.DOWN : 0)));

          if (tilePosition.y - obstacle.size.y / 2 ==  targetPosition.y + targetSize.y / 2 || tilePosition.y + obstacle.size.y / 2 ==  targetPosition.y - targetSize.y / 2) {
            collision.x = 0;
          }

          tileGroup.obstacles.remove(i);
          return obstacle;
        }

        i++;
      }
    }

    return null;
  }

  /**
   * @author Cody Bolleboom
   * Check if a chunk is out of frame and delete it and create a new one
   * this will also checks if a chunk is available yet (some will be available after a certain distance)
   *
   * @return void
   */
  void listener() {
    println("pool size: " + difficultyPool.size());
    for (int i = 0; i < difficultyPool.size(); i++) {
      if ((float)difficultyPool.get(i).getFloat("start") <= poolDistance) {
          usePool.add(difficultyPool.get(i));
          difficultyPool.remove(i);
        }
    }
    
    for (int i = 0; i < usePool.size(); i++) {
      JSONObject group = usePool.get(i);
      if (group.getFloat("stop") != -1 && group.getFloat("stop") <= poolDistance) {
        usePool.remove(i);
      }
    }
    
    
    //check if there are any chunks loaded
    if (tileGroups.size() > 0) {

      //get the most left chunk
      TileGroup group = tileGroups.get(0);
      //check if the most left chunk is out of frame
      if (group.position.x < -defaultGroupWidth) {
        //delete the most left chunk
        tileGroups.remove(0);


        TileGroup lastGroup = tileGroups.get(tileGroups.size() - 1);

        //create a new chunk to the right of the most right chunk
        TileGroup newGroup = new TileGroup(new PVector(lastGroup.position.x + defaultGroupWidth, height - bottomOffset));
        //add the tile positions of a random chunk to the new chunk
        newGroup.loadGroup(usePool.get(Math.round(random(0, usePool.size() - 1))));
        //add the chunk to the manager list
        tileGroups.add(newGroup);
      }
    }
  }

  /**
   * This loads a new chunk pool if the player fell down
   */
  void playerLocation(Player player) {
    if (player.playerPos.y>=height-(Config.PLAYER_SIZE.y/2)) {

      chunkpool++;
      poolDistance = 0;

      tileGroups = new ArrayList<TileGroup>();
      for (int i = 0; i < startingGroups; i++) {
        //create a new chunk to the right of the most right chunk
        TileGroup newGroup = new TileGroup(new PVector(i * defaultGroupWidth, height - bottomOffset));
        //add the tile positions of a random chunk to the new chunk
        newGroup.loadGroup(chunkPool.getJSONArray(chunkpool).getJSONObject(Math.round(random(0, chunkPool.getJSONArray(chunkpool).size() - 1))));
        //add the chunk to the manager list
        tileGroups.add(newGroup);
      }

      usePool = new ArrayList<JSONObject>();
      difficultyPool = new ArrayList<JSONObject>();
      for (int i = 0; i < chunkPool.getJSONArray(chunkpool).size(); i++) {
        if (chunkPool.getJSONArray(chunkpool).getJSONObject(i).getFloat("start") != 0) {
          difficultyPool.add(chunkPool.getJSONArray(chunkpool).getJSONObject(i));
        } else {
          usePool.add(chunkPool.getJSONArray(chunkpool).getJSONObject(i));
        }
      }
    }
  }
}

class TileCollision {
  PVector direction = new PVector();
  PVector position;
}
