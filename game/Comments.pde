/**
 * @author Antonio Bottelier
 *
 * The comment database is a wrapper for the Database
 * that allows the uploading of comments and retrieving the comments
 * to be shown on the scren.
 */
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
    Table commentTable = database.runQuery(String.format("SELECT distance, content FROM comment WHERE distance BETWEEN %d AND %d", minRange, maxRange));
    if(commentTable.getRowCount() == 0) return null;

    ArrayList<Comment> comments = new ArrayList<Comment>();

    for(int row = 0; row < commentTable.getRowCount(); row++)
    {
      int distance = 0;
      String content = null;
      distance = commentTable.getInt(row, 0);
      content = commentTable.getString(row, 1);

      comments.add(new Comment(content, distance));
    }

    return comments;
  }
  
  /*
   * Get all comments by name (NOT IMPLEMENTED!)
   */
  public ArrayList<Comment> getCommentsByName(String name)
  {
     Table commentTable = database.runQuery(
       String.format("SELECT comment.distance, comment.content, player.name FROM comment INNER JOIN player ON player.id = comment.player_id WHERE player.name = '%s'",
         name));
     
     ArrayList<Comment> comments = new ArrayList<Comment>();
     
     return comments;
  }

  /*
   * Add a comment to the database
   */
  public void addComment(Comment comment)
  {
    database.updateQuery(
        String.format("INSERT INTO comment (distance, content, player_id, created_on) values (%d, \"%s\", %d, CURRENT_TIMESTAMP)", 
          comment.getDistance(), comment.getContent(), comment.getPlayerId()));
  }
  
  /*
   * Update a comment's values
   */
  public void updateComment(int id, Comment comment)
  {
    database.updateQuery(
      String.format("UPDATE comment SET distance = %d, content = '%s', player_id = %d WHERE id = %d", 
        comment.getDistance(), comment.getContent(), comment.getPlayerId(), id));
  }
}
