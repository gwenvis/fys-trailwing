/**
 Made Cody Bolleboom
 29-09-2020 13:33
 */

class TileGroup {
  ArrayList<Tile> tiles;
  PVector position;
  
  //Copies tile position in position.
  TileGroup(PVector tempPos) {
    position = tempPos;
  }
  
  // Loops through all tiles in the array and draws it relative to the tiles that are already drawn.
  void drawGroup() {
    for(int i = 0; i < tiles.size(); i ++ ) {
      tiles.get(i).drawTileRelative(position);
    }
  }
}
