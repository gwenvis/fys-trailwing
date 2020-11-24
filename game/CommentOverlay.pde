/* @author Antonio Bottelier
 *
 * Overlay for when you die to start commenting
 */
public class CommentOverlay
{
  private String commentInput = "";
  private boolean firstFrameSkipped = false;

  public boolean update()
  { 
    // Ignore the first frame ( for keyboard input ) 
    if(!firstFrameSkipped)
    {
      firstFrameSkipped = true;
      return false;
    }

    handleKeyboard();
    return Input.keyClicked(RETURN) || Input.keyClicked(ENTER);
  }

  public void handleKeyboard()
  {
    commentInput = Keyboard.update(commentInput);
  }

  public String getCommentInput()
  {
    return commentInput;
  }

  public void draw() 
  {
    textSize(32);
    fill(255, 0, 0);
    textAlign(LEFT);
    text("Comment: " + commentInput, 50, height - 50);
  }
}
