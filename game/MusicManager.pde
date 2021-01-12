/** 
 * @author Antonio Bottelier
 *
 * The Music Manager loads all song data specified in the json file.
 * It checks what state the game is in, and plays the songs depending on the state.
 * When there is an alias specified, it checks whether the new state is an alias, and if it is it continues the
 * music from the previous state (or plays it again if the previous state is not the correct state)
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
  private StateMusicCategory currentCategory = null;

  public MusicManager(PApplet p)
  {
    preload(p);
  }

  /*
   * updates the music manager, checks if the state has switched
   * and if it has it plays the new music.
   */
  public void update()
  {
    if (lastState != gameState)
    {
      if ((currentCategory == music.get(gameState)) || (currentCategory != null && currentCategory.isAlias(gameState)))
      {
        lastState = gameState;
        return;
      }

      lastSongIndex = -1;
      lastState = gameState;
      stopCurrentSong();
      selectNewSong();
      if (currentSong != null) println("playing new song " + currentSong.fileName);
      else println("no new song found. Bummer.");
      playCurrentSong();
      setVolume(volume);
    }

    // wait until the current song has ended before picking a new one
    if ((currentSong == null || currentSong.isPlaying()) || !currentCategory.loop ) return;

    selectNewSong();
    playCurrentSong();
    setVolume(volume);
  }

  /*
   * Sets volume of all songs
   */
  public void setVolume(float volume)
  {
    this.volume = volume;
    if (currentSong != null)
    {
      currentSong.setVolume(volume);
    }
  }

  /*
   * Get the current volume.
   */
  public float getVolume()
  {
    return volume;
  }

  /* 
   * Plays the current song.
   */
  private void stopCurrentSong()
  {
    if (currentSong != null) currentSong.stop();
  }

  /*
   * Stops the current song
   */
  private void playCurrentSong()
  {
    if (currentSong == null) return;
    currentSong.play();
    currentSong.sound.jump(0);
  }

  /*
   * Choose a new random song from the current state.
   */
  private void selectNewSong()
  {
    currentSong = null;
    currentCategory = null;
    if (!music.containsKey(lastState)) return; // .. if it exists, of course.

    currentCategory = music.get(lastState);
    int randomIndex = -1;
    int tries = 5;
    do {
      randomIndex = (int)random(0, currentCategory.getSongCount());
      tries--;
    } while (tries > 0 && (randomIndex != lastSongIndex || !preventRepetition));

    currentSong = currentCategory.getSong(randomIndex);
  }

  /*
   * Preload the music specified in the JSON file.
   */
  public void preload(PApplet p)
  {
    music = new HashMap<String, StateMusicCategory>();
    JSONArray musicData = loadJSONArray(MUSIC_DATA_PATH);
    for (int i = 0; i < musicData.size(); i++)
    {
      JSONObject stateData = musicData.getJSONObject(i);
      String stateName = stateData.getString("state");

      ArrayList<Song> songs = new ArrayList<Song>();
      JSONArray stateSongsData = stateData.getJSONArray("songs");
      for (int j = 0; j < stateSongsData.size(); j++)
      {
        JSONObject s = stateSongsData.getJSONObject(j);
        String fileName = s.getString("fileName");
        float volume = s.getFloat("volume");
        SoundFile soundFile = new SoundFile(p, fileName);
        songs.add(new Song(soundFile, fileName, volume));
      }

      boolean loop = stateData.getBoolean("loop", true);
      StateMusicCategory stateMusic = new StateMusicCategory(songs, getAlias(stateData), loop);
      music.put(stateName, stateMusic);
    }

    println(music.get("START").getSongCount());
  }

  private String[] getAlias(JSONObject o)
  {
    JSONArray alia = o.getJSONArray("alias");
    if (alia == null || alia.size() == 0) return null;
    String[] alias = new String[alia.size()];
    for (int i = 0; i < alias.length; i++)
    {
      alias[i] = alia.getString(i);
    }
    return alias;
  }
}
