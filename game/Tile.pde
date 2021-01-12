/**
 Made by Cody Bolleboom
 29-09-2020 13:33
 */

class Tile {
  PVector position;
  PVector relativePosition;
  PVector size;
  PImage sprite;
  boolean enabled = true;
  String layer;

  /**
   * @author Cody Bolleboom
   * This constructor sets the sprite, size and position
   */
  Tile(String spritePath, PVector spriteSize, PVector spritePosition, String spriteLayer) {
    sprite = loadImage(spritePath);
    size = spriteSize;
    position = spritePosition;
    layer = spriteLayer;
  }

  Tile() {
  }

  /**
   * @author Cody Bolleboom
   * This function is used to draw a sprite from the given position
   *
   * @returns void
   */
  void drawTile() {
    imageMode(CENTER);
    if (!enabled) return;
    update();
    image(sprite, position.x, position.y, size.x, size.y);
  }

  // update is overridden
  void update() {
  }

  /**
   * @author Cody Bolleboom
   * This function is used to draw a sprite relative from another position.
   * This is also used in the TileGroup to use its positions as a parent
   *
   * @param PVector parent This variable is filled with the relative position
   * @returns void
   */
  void drawTileRelative(PVector parent) {
    imageMode(CENTER);
    if (!enabled) return;
    relativePosition = new PVector(position.x + parent.x, position.y + parent.y);
    update();
    image(sprite, position.x + parent.x, position.y + parent.y, size.x, size.y);
  }
}
