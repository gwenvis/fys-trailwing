public class Song
{
  public SoundFile sound;
  public String fileName;
  public float volume;

  private float calcVolume;

  public Song(SoundFile sound, String fileName, float volume)
  {
    this.sound = sound;
    this.fileName = fileName;
    this.volume = volume;
    calcVolume = volume;
  }

  public void play()
  {
    sound.play();
    sound.amp(volume);
  }

  public void setVolume(float volume)
  {
    if (volume == calcVolume) return;
    calcVolume = volume * this.volume;
    sound.amp(calcVolume);
  }

  public void stop()
  {
    sound.stop();
  }

  public boolean isPlaying()
  {
    return sound.isPlaying();
  }
}
