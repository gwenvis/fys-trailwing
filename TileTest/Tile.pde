/**
 Made Cody Bolleboom
 29-09-2020 13:33
 */

class Tile {
  PVector position;
  PVector size;
  PImage sprite;
  
  Tile(String spritePath) {
    sprite = loadImage(spritePath);
  }

  void drawTile() {
    image(sprite, position.x, position.y, size.x, size.y);
  }

  void drawTileRelative(PVector parent) {
    image(sprite, position.x + parent.x, position.y + parent.y, size.x, size.y);
  }

  boolean checkCollision() {
    return false;
  }
}
