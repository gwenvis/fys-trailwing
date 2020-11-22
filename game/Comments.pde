public class CommentsDatabase
{
  Database database;

  CommentsDatabase()
  {
    database = new Database("jdbc:mysql://oege.ie.hva.nl:3306/zbottela", true, "bottela", "VKRrXbEOm#Pvqb");
  }

  /*
   * Gets comments with the location in between the range.
   */
  public ArrayList<Comment> getComments(int minRange, int maxRange) 
  {
    Table commentTable = database.runQuery("SELECT location, content FROM Comment");
    if(commentTable.getRowCount() == 0) return null;

    ArrayList<Comment> comments = new ArrayList<Comment>();

    for(int row = 0; row < commentTable.getRowCount(); row++)
    {
      int distance = 0;
      String content = null;
      for(int col = 0; col < commentTable.getColumnCount(); col++)
      {
        if(col == 0) distance = commentTable.getInt(row, col);
        if(col == 1) content = commentTable.getString(row, col);
      }

      comments.add(new Comment(content, distance));
    }

    return comments;
  }

  public void addComment(Comment comment)
  {
    database.updateQuery(
        String.format("INSERT INTO Comment (location, content, player_ID) values (%d, \"%s\", %d)", 
          comment.getDistance(), comment.getContent(), 0));
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
