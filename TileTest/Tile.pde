/**
 Made Cody Bolleboom
 29-09-2020 13:33
 */

class Tile {
  PVector position;
  PVector size;
  PImage sprite;
  
  /**
  * This constructor sets the sprite, size and position
  */
  Tile(String spritePath, PVector spriteSize, PVector spritePosition) {
    sprite = loadImage(spritePath);
    size = spriteSize;
    position = spritePosition;
  }

  /**
  * This function is used to draw a sprite from the given position
  *
  * @returns void
  */
  void drawTile() {
    image(sprite, position.x, position.y, size.x, size.y);
  }

  /**
  * This function is used to draw a sprite relative from another position.
  * This is also used in the TileGroup to use its positions as a parent
  *
  * @param PVector parent This variable is filled with the relative position
  * @returns void
  */
  void drawTileRelative(PVector parent) {
    image(sprite, position.x + parent.x, position.y + parent.y, size.x, size.y);
  }
}
