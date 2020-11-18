/**
 Made Cody Bolleboom
 29-09-2020 13:33
 */

class Obstacle extends Tile {
  float damage;
  
    /**
   * @author Cody Bolleboom
   * sets the Tile constructor variables
   */
  Obstacle(String spritePath, PVector spriteSize, PVector spritePosition, float obstacleDamage, String spriteLayer) {
    super(spritePath, spriteSize, spritePosition, spriteLayer);
    damage = obstacleDamage;
  }
}
