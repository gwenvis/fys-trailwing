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

  public boolean isAlias(String alias)
  {
    if(this.alias == null || this.alias.length == 0) return false;

    for(String a : this.alias)
    {
      if(a.equals(alias)) return true;
    }

    return false;
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
