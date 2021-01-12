/**
 * @author Antonio Bottelier
 *
 * StateMusicCategory class is a Music Bank for a specific category of music.
 * It holds all songs and the names, and allows retrieving a specific song.
 */
public class StateMusicCategory
{
  private ArrayList<Song> songs;
  private String[] alias;
  private boolean loop;

  public StateMusicCategory(ArrayList<Song> songs, String[] alias, boolean loop)
  {
    this.songs = songs;
    this.alias = alias;
    this.loop = loop;
  }

  /*
   * Check if string is an alias.
   */
  public boolean isAlias(String alias)
  {
    if (this.alias == null || this.alias.length == 0) return false;

    for (String a : this.alias)
    {
      if (a.equals(alias)) return true;
    }

    return false;
  }

  /*
   * Gets song with specified index.
   */
  public Song getSong(int index)
  {
    return songs.get(index);
  }

  /*
   * Get the Song Count.
   */
  public int getSongCount() { 
    return songs.size();
  }

  /*
   * Gets a song with the filename.
   */
  public Song getSong(String fileName)
  {
    for (Song song : songs)
    {
      if (song.fileName.equals(fileName)) return song;
    }

    return null;
  }
}
