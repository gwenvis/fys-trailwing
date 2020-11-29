/* @author Antonio Bottelier
 */
public class MusicManager
{
  private final String MUSIC_DATA_PATH = "json/songs.json";
  private HashMap<String, StateMusicCategory> music;
  private String lastState;
  private int lastSongIndex = -1;
  private boolean preventRepetition = true;
  private float volume = 1.0f;

  private Song currentSong = null;

  public MusicManager(PApplet p)
  {
    preload(p);
  }

  public void update()
  {
    if(lastState != gameState)
    {
      lastSongIndex = -1;
      lastState = gameState;
      stopCurrentSong();
      selectNewSong();
      if(currentSong != null) println("playing new song " + currentSong.fileName);
      else println("no new song found. Bummer.");
      playCurrentSong();
      setVolume(volume);
    }
    
    // wait until the current song has ended before picking a new one
    if(currentSong == null || currentSong.isPlaying()) return;

    selectNewSong();
    playCurrentSong();
    setVolume(volume);
  }

  public void setVolume(float volume)
  {
    this.volume = volume;
    if(currentSong != null)
    {
      currentSong.setVolume(volume);
    }
  }

  public float getVolume()
  {
    return volume;
  }

  private void stopCurrentSong()
  {
    if(currentSong != null) currentSong.stop();
  }

  private void playCurrentSong()
  {
    if(currentSong == null) return;
    currentSong.play();
    currentSong.sound.jump(0);
  }

  private void selectNewSong()
  {
    // select a random song from the current state.
    currentSong = null;
    if(!music.containsKey(lastState)) return; // .. if it exists, of course.

    StateMusicCategory currentCategory = music.get(lastState);
    int randomIndex = -1;
    int tries = 5;
    do {
      randomIndex = (int)random(0, currentCategory.getSongCount());
      tries--;
    } while(tries > 0 && (randomIndex != lastSongIndex || !preventRepetition));

    currentSong = currentCategory.getSong(randomIndex);
  }

  public void preload(PApplet p)
  {
    music = new HashMap<String, StateMusicCategory>();
    JSONArray musicData = loadJSONArray(MUSIC_DATA_PATH);
    for(int i = 0; i < musicData.size(); i++)
    {
      JSONObject stateData = musicData.getJSONObject(i);
      String stateName = stateData.getString("state");

      ArrayList<Song> songs = new ArrayList<Song>();
      JSONArray stateSongsData = stateData.getJSONArray("songs");
      for(int j = 0; j < stateSongsData.size(); j++)
      {
        JSONObject s = stateSongsData.getJSONObject(j);
        String fileName = s.getString("fileName");
        float volume = s.getFloat("volume");
        SoundFile soundFile = new SoundFile(p, fileName);
        songs.add(new Song(soundFile, fileName, volume));
      }

      StateMusicCategory stateMusic = new StateMusicCategory(songs);
      music.put(stateName, stateMusic);
    }

    println(music.get("START").getSongCount());
  }
}

public class StateMusicCategory
{
  private ArrayList<Song> songs;

  public StateMusicCategory(ArrayList<Song> songs)
  {
    this.songs = songs;
  }

  public Song getSong(int index)
  {
    return songs.get(index);
  }

  public int getSongCount() { return songs.size(); }

  public Song getSong(String fileName)
  {
    for(Song song : songs)
    {
      if(song.fileName.equals(fileName)) return song;
    }

    return null;
  }
}

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
    if(volume == calcVolume) return;
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
