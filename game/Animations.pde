/*
 * @author Antonio Bottelier
 *
 * Initiliazies all animation for global use. The Animations class is instantiated in the root project 
 * and can be accessed from everywhere.
 */
public class Animations
{
  // initialize animations here.
  public Animations() {
    PLAYER_WALK = new Animation("player_running.png", 8, 1);
    PLAYER_WALK.setAnimationSpeed(5);
  }
  
  // declarer animations here
  public Animation PLAYER_WALK = null;
}
