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

  public void update()
  {
    if (!shouldDraw) return;
    position.x -= manager.speed;
  }

  public void appear()
  {
    shouldDraw = true;
  }

  public boolean shouldAppear(int distance)
  {
    return comment.distance < distance;
  }

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
