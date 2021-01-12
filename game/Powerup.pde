/**
 * @author Antonio Bottelier
 * The powerup class detects collision with the player
 * and then gives the player the appropriate powerup.
 */
public class Powerup extends Tile
{
  ArrayList<PImage> sprites;

  PowerupType powerUpType;

  Powerup(PowerupType powerUpType, PVector pos, PVector size) {
    this.powerUpType = powerUpType;
    this.position = pos;
    this.size = size;

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
    // aabb -> test collision with player
    
    PVector playerPos = player.playerPos;
    PVector playerSize = player.size;
    boolean hCol = relativePosition.x < playerPos.x + playerSize.x 
      && relativePosition.x + size.x > playerPos.x;
    boolean vCol = relativePosition.y < playerPos.y + playerSize.y
      && relativePosition.y + size.y > playerPos.y;

    // give the player the powerup if collided
    if(vCol && hCol) {
      enabled = false;
      player.givePowerUp(powerUpType);

      if(powerUpType == PowerupType.INVINCIBILITY)
      {
        soundBank.playSound(SoundType.INVICIBILITY_GRAB);
      }
      else
      {
        soundBank.playSound(SoundType.JUMP_BOOST_GRAB);
      }
    }
  }
}
