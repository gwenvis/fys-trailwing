/**
 * Made by Antonio Bottelier
 */

public class Powerup extends Tile
{
  boolean enabled = true;

  ArrayList<PImage> sprites;

  PowerupType powerUpType;

  Powerup(PowerupType powerUpType) {
    this.powerUpType = powerUpType;

    if(sprites == null) {
      sprites = new ArrayList<PImage>();
      for(int i = 0; i < Config.POWERUP_SPRITENAMES.length; i++) {
        sprites.add(loadImage(Config.POWERUP_SPRITENAMES[i]));
      }
    }

    this.sprite = sprites.get(powerUpType.getValue());
  }

  @Override
  void update() {
    // test collision with player
    
    PVector playerPos = player.playerPos;
    PVector playerSize = player.size;
    boolean hCol = position.x < playerPos.x + playerSize.x 
      && position.x + size.x > playerPos.x;
    boolean vCol = position.y < playerPos.y + playerSize.y
      && position.y + size.y > playerPos.y;

    if(vCol && hCol) {
      enabled = false;
      player.givePowerUp(powerUpType);
    }
  }
}
