/**
 Made Cody Bolleboom
 29-09-2020 13:33
 */

class TileGroup {
  ArrayList<Tile> tiles = new ArrayList<Tile>();
  ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
  ArrayList<PVector> powerups = new ArrayList<PVector>();
  Powerup powerup;
  PVector position;

  //Copies tile position in position. (Patrick Eikema)
  TileGroup(PVector tempPos) {
    position = tempPos;
  }
  
  // Loops through all tiles in the array and draws it relative to the tiles that are already drawn. (Patrick Eikema)
  void copyPosition(TileGroup group) {
    tiles = group.tiles;
    obstacles = group.obstacles;
    powerups = group.powerups;
    powerup = group.powerup;
  }

  void drawGroup() {
    for (int i = 0; i < tiles.size(); i ++ ) {
      tiles.get(i).drawTileRelative(position);
    }

    for (Obstacle obstacle : obstacles) {
      obstacle.drawTileRelative(position);
    }

    if(powerup != null)
      powerup.drawTileRelative(position);
  }

  /**
   * @author Cody Bolleboom
   * This function loads the chunks json file and builds the level
   *
   * @param JSONArray chunks array taken out the data/chunks.json
   * @param int this is the array index of the needed chunk
   * @returns void
   */
  void loadGroup(JSONObject chunk) {
    //get a single chunk by the given index

    //gets the tiles of the chunk
    JSONArray chunkTiles = chunk.getJSONArray("tiles");
    //loop through the 
    for (int i = 0; i < chunkTiles.size(); i++) {
      //get the single tile as an object
      JSONObject tile = chunkTiles.getJSONObject(i);

      //add the tile with its variables to the tile array
      tiles.add(new Tile(tile.getString("sprite"), 
        new PVector(tile.getFloat("width"), tile.getFloat("height")), 
        new PVector(tile.getFloat("x"), tile.getFloat("y")),  //<>// //<>// //<>//
        tile.getString("layer")));
    }

    //gets the obstacles of the chunk
    JSONArray chunkObstacles = chunk.getJSONArray("obstacles");
    //loop through the  //<>// //<>// //<>// //<>//
    for (int n = 0; n < chunkObstacles.size(); n++) {
      //get the single obstacles as an object
      JSONObject obstacle = chunkObstacles.getJSONObject(n);

      //add the tile with its variables to the tile array
      obstacles.add(new Obstacle(obstacle.getString("sprite"),  //<>// //<>// //<>// //<>//
        new PVector(obstacle.getFloat("width"), obstacle.getFloat("height")), 
        new PVector(obstacle.getFloat("x"), obstacle.getFloat("y")), 1, obstacle.getString("layer")));
    }

    JSONArray chunkPowerups = chunk.getJSONArray("powerups");

    for(int i = 0; i < chunkPowerups.size(); i++) {
      JSONObject powerup = chunkPowerups.getJSONObject(i);

      powerups.add(new PVector(powerup.getFloat("x"), powerup.getFloat("y")));
    }

    float spawnChance = random(0, 100);
    boolean spawn = spawnChance < Config.POWERUP_SPAWN_CHANCE;
    if(spawn)
    {
      PowerupType pType = PowerupType.values()[(int)random(0, PowerupType.values().length)];
      PVector size = new PVector(Config.POWERUP_WIDTH, Config.POWERUP_HEIGHT);
      powerup = new Powerup(pType, powerups.get((int)random(0, powerups.size())), size);
    }
  }
}
