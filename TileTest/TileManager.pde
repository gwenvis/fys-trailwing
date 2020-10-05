/**
 Made Cody Bolleboom
 05-10-2020 10:44
 */

class TileManager {
  ArrayList<TileGroup> tiles = new ArrayList<TileGroup>();
  int speed = 5;

  //Moves all the tiles. (Patrick Eikema)
  void move() {
    for(int i = 0; i < tiles.size(); i++){
      tiles.get(i).position.x -= speed;
      
    }
  }
  /**
   * This function loads the chunks json file and builds the level
   *
   * @param int this is the array index of the needed chunk
   * @returns void
   */
  void loadGroup(int chunkIndex) {
    //Get the chunks from the file
    JSONArray chunks = loadJSONArray("json/chunks.json");
    //get a single chunk by the given index
    JSONObject chunk = chunks.getJSONObject(chunkIndex);

    //gets the tiles of the chunk
    JSONArray chunkTiles = chunk.getJSONArray("tiles");
    //loop through the 
    for (int i = 0; i < chunkTiles.size(); i++) {
      //get the single tile as an object
      JSONObject tile = chunkTiles.getJSONObject(i);

      //add the tile with its variables to the tile array
      tiles.add(new Tile(tile.getString("sprite"), 
        new PVector(tile.getFloat("width"), tile.getFloat("height")), 
        new PVector(tile.getFloat("x"), tile.getFloat("y"))));
    }
  }
}
