/**
 * @author Antonio Bottelier
 *
 * Database data for a comment.
 */
public class Comment
{
  public Comment(String content, int distance)
  {
    this.content = content;
    this.distance = distance;
  }

  private String content;
  private int distance;

  public String getContent() { 
    return content;
  }
  public int getDistance() { 
    return distance;
  }
  public int getPlayerId() { 
    return 0;
  }
}
