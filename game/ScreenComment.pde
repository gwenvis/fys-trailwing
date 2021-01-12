/**
 * @author Antonio Bottelier
 * 
 * Comment that is shown on the screen.
 */
public class ScreenComment
{
  public PVector position;

  private Comment comment;
  private String content;
  private boolean shouldDraw = false;
  private int textSize = 32;

  public ScreenComment(Comment comment)
  {
    this.comment = comment;
    content = comment.getContent();
    position = new PVector(width, random(0, height - textSize));
  }

  /*
   * Update the comment position if it should be drawn
   */
  public void update()
  {
    if (!shouldDraw) return;
    position.x -= manager.speed;
  }

  /* 
   * Let the comment appear on the screen and update
   */
  public void appear()
  {
    shouldDraw = true;
  }

  /*
   * Check if the comment should appear
   */
  public boolean shouldAppear(int distance)
  {
    return comment.distance < distance;
  }

  /*
   * Check if the comment is out of the screen.
   */
  public boolean isDead()
  {
    return position.x < -500;
  }

  public void draw()
  {
    if (!shouldDraw) return;
    fill(255);
    textAlign(LEFT);
    textSize(textSize);
    text(content, position.x, position.y);
  }
}
