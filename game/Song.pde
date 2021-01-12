/**
 * @author Antonio Bottelier
 *
 * Holds all sound data, with filename, volume and the song file.
 * Allows playing of the song, setting volume of it, and stopping the song.
 */
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

  /*
   * Play the song and automatically sets the volume
   */
  public void play()
  {
    sound.play();
    sound.amp(volume);
  }

  /*
   * Sets the volume calculated with the song volume and specified volume.
   */
  public void setVolume(float volume)
  {
    if (volume == calcVolume) return;
    calcVolume = volume * this.volume;
    sound.amp(calcVolume);
  }

  /*
   * Stop the song.
   */
  public void stop()
  {
    sound.stop();
  }

  /*
   * Check whether the song is still playing.
   */
  public boolean isPlaying()
  {
    return sound.isPlaying();
  }
}
