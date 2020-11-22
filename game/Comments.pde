public class CommentsDatabase
{
  Database database;

  CommentsDatabase()
  {
    database = new Database("no link yet", true, "", "");
  }

  public ArrayList<Comment> getComments() 
  {
    return null;
  }
}

public class Comment
{
  public Comment(String content, int distance)
  {
    this.content = content;
    this.distance = distance;
  }

  private String content;
  private int distance;

  public String getContent() { return content; }
  public int getDistance() { return distance; }
}
