/**
 Made Cody Bolleboom
 29-09-2020 13:33
 */

class TileGroup {
  ArrayList<Tile> tiles = new ArrayList<Tile>();
  PVector position;

  //Copies tile position in position.
  TileGroup(PVector tempPos) {
    position = tempPos;
  }

  // Loops through all tiles in the array and draws it relative to the tiles that are already drawn.
  void drawGroup() {
    for (int i = 0; i < tiles.size(); i ++ ) {
      tiles.get(i).drawTileRelative(position);
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
