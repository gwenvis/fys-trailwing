/**
 * Made by Antonio Bottelier
 */

public class Powerup extends Tile
{
  ArrayList<PImage> sprites;

  PowerupType powerUpType;
  RunnerScreen screen; 

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
    screen = (RunnerScreen)currentScreen;
  }

  @Override
  void update() {
    // test collision with player
    
    PVector playerPos = screen.player.playerPos;
    PVector playerSize = screen.player.size;
    boolean hCol = relativePosition.x < playerPos.x + playerSize.x 
      && relativePosition.x + size.x > playerPos.x;
    boolean vCol = relativePosition.y < playerPos.y + playerSize.y
      && relativePosition.y + size.y > playerPos.y;

    if(vCol && hCol) {
      enabled = false;
      screen.player.givePowerUp(powerUpType);
    }
  }
}
