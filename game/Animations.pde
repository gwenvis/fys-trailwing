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
