/**
 * @author Antonio Bottelier
 *
 * Allows adding screenshake to the game by sending
 * screenshake requests to the class. Sends back offsets
 */
public class ScreenShake
{
  // screen shake time in frames
  private final int SCREEN_SHAKE_TIME = 60;
  private final int SCREEN_SHAKE_EASE_TIME = 30;
  private final float SCREEN_SHAKE_STRENGTH_X = 3.0f;
  private final float SCREEN_SHAKE_STRENGTH_Y = 3.0f;

  private int currentScreenShakeTime = 0;

  /*
   * Adds screenshake with the specified time.
   * Use -1 to use a default screenshake time.
   */
  public void addScreenShake(int time)
  {
    if(time == -1)
    {
      currentScreenShakeTime = SCREEN_SHAKE_TIME;
      return;
    }

    currentScreenShakeTime = time;
  }

  /*
   * Adds default screenshake time.
   */
  public void addScreenShake() { addScreenShake(-1); }

  // Gets the offset and updates the values for the next screen shake.
  public PVector getOffset()
  {
    if(currentScreenShakeTime == 0)
    {
      return new PVector(0,0);
    }

    currentScreenShakeTime--;
    float x = random(-SCREEN_SHAKE_STRENGTH_X, SCREEN_SHAKE_STRENGTH_X);
    float y = random(-SCREEN_SHAKE_STRENGTH_Y, SCREEN_SHAKE_STRENGTH_Y);

    // apply easing when time is low
    float multiplication = currentScreenShakeTime / SCREEN_SHAKE_EASE_TIME;
    if(multiplication > 1) multiplication = 1;

    return new PVector(x*multiplication, y*multiplication);
  }

  /*
   * Check if there is any screenshake time available.
   */
  public boolean isAvailable()
  {
    return currentScreenShakeTime > 0;
  }
}
