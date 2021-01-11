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

    sounds.put(SoundType.JUMP, new Sound(0.6f, app,
          "sounds/jump1.wav", "sounds/jump2.wav"));
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
  JUMP,
  FOOTSTEP,
  BARREL_HIT
}
