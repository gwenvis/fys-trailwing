/**
 * @author Antonio Bottelier
 *
 * Sound data for the SoundBank. Holds multiple sounds and calling play()
 * returns a random sound from the list.
 */
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

