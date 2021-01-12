/**
 * @author Antonio Bottelier
 *
 * Preloads all sounds in the game and allows the playing
 * of sounds with the SoundType enum.
 */
public class SoundBank
{
  private HashMap<SoundType, Sound> sounds;

  public SoundBank(PApplet app)
  {
    sounds = new HashMap<SoundType, Sound>();
    sounds.put(SoundType.FOOTSTEP, new Sound(0.6f, app, 
      "sounds/foot1.wav", "sounds/foot2.wav", 
      "sounds/foot3.wav", "sounds/foot4.wav", 
      "sounds/foot5.wav", "sounds/foot6.wav"));

    sounds.put(SoundType.JUMP, new Sound(0.67f, app, 
      "sounds/jump1.wav", "sounds/jump2.wav"));

    sounds.put(SoundType.BARREL_HIT, new Sound(0.6f, app, 
      "sounds/barrel1.wav", "sounds/barrel2.wav"));

    sounds.put(SoundType.DRAGON_BRUL, new Sound(0.8f, app, 
      "sounds/moan1.wav", "sounds/moan2.wav"));

    sounds.put(SoundType.FIRE_START, new Sound(0.6f, app, "sounds/fire1.wav"));

    sounds.put(SoundType.FIRE_SHOOT, new Sound(0.75f, app, "sounds/breath1.wav"));

    sounds.put(SoundType.HURT, new Sound(0.6f, app, "sounds/hurt1.wav", "sounds/hurt2.wav"));

    sounds.put(SoundType.DEATH, new Sound(0.6f, app, "sounds/death1.wav"));

    sounds.put(SoundType.SHIELD_HIT, new Sound(0.6f, app, "sounds/shield1.wav"));

    sounds.put(SoundType.INVICIBILITY_GRAB, new Sound(0.6f, app, "sounds/potion1.wav"));

    sounds.put(SoundType.JUMP_BOOST_GRAB, new Sound(0.6f, app, "sounds/jumppower1.wav"));

    sounds.put(SoundType.MAIN_MENU_ENTER, new Sound(0.6f, app, "sounds/mainmenu1.wav"));

    sounds.put(SoundType.BUTTON_NAVIGATE, new Sound(0.6f, app, "sounds/buttonmove1.wav"));

    sounds.put(SoundType.BUTTON_SELECT, new Sound(0.6f, app, "sounds/buttonselect1.wav"));

    sounds.put(SoundType.COIN, new Sound(0.4f, app, "sounds/coin1.wav"));

    sounds.put(SoundType.LAVA_BUBBLE, new Sound(0.6f, app, "sounds/lava.wav"));

    sounds.put(SoundType.LAVA_DEATH, new Sound(0.6f, app, "sounds/lavadeath1.wav"));
  }

  /*
   * Play sound with the specified SoundType
   */
  public void playSound(SoundType soundType)
  {
    sounds.get(soundType).play();
  }

  /*
   * Gets the sound file.
   */
  public SoundFile getSoundFile(SoundType soundType)
  {
    return sounds.get(soundType).get();
  }
}
