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
    
    sounds.put(SoundType.DRAGON_BRUL, new Sound(0.6f, app,
          "sounds/moan1.wav", "sounds/moan2.wav"));

    sounds.put(SoundType.FIRE_START, new Sound(0.6f, app, "sounds/fire1.wav"));

    sounds.put(SoundType.FIRE_SHOOT, new Sound(0.6f, app, "sounds/breath1.wav"));

    sounds.put(SoundType.HURT, new Sound(0.6f, app, "sounds/hurt1.wav", "sounds/hurt2.wav"));

    sounds.put(SoundType.DEATH, new Sound(0.6f, app, "sounds/death1.wav"));

    sounds.put(SoundType.SHIELD_HIT, new Sound(0.6f, app, "sounds/shield1.wav"));
    
    sounds.put(SoundType.INVICIBILITY_GRAB, new Sound(0.6f, app, "sounds/potion1.wav"));
  }

  public void playSound(SoundType soundType)
  {
    sounds.get(soundType).play();
  }
}

public class Sound
{
  private ArrayList<SoundFile> sounds;
  private float volume;

  public Sound(float volume, PApplet app, String... sounds)
  {
    this.sounds = new ArrayList<SoundFile>();
    this.volume = volume;

    for(int i = 0; i < sounds.length; i++)
    {
      this.sounds.add(new SoundFile(app, sounds[i])); 
    }
  }

  public void play()
  {
    int index = (int)random(0, sounds.size());
    SoundFile file = sounds.get(index);

    if(file == null)
    {
      println("null.. " + index);
    }

    file.amp(volume);
    file.play();
  }
}

enum SoundType
{
  DRAGON_BRUL,
  FIRE_START,
  FIRE_SHOOT,
  JUMP,
  FOOTSTEP,
  BARREL_HIT,
  HURT,
  DEATH,
  SHIELD_HIT,
  INVICIBILITY_GRAB
}
