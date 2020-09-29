/**
 Made Cody Bolleboom
 29-09-2020 13:33
 */

class TileGroup {
  ArrayList<Tile> tiles;
  PVector position;
  

  void drawGroup() {
    for(int i = 0; i < tiles.size(); i ++ ) {
      tiles.get(i).drawTileRelative(position);
    }
  }
}
