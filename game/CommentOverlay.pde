/* @author Antonio Bottelier
 *
 * Overlay for when you die to start commenting
 */
public class CommentOverlay implements IKeyboardCallback
{
  

  private String commentInput = "";
  private boolean firstFrameSkipped = false;
  private KeyboardHUD keyboardHud;

  private boolean discarded = false;
  private boolean submitted = false;
  private float textWidth;

  public CommentOverlay() 
  {
    keyboardHud = new KeyboardHUD(this, new PVector(0,height/2+50), 20);
    keyboardHud.position.x = width/2-keyboardHud.getWidth()/2;

    textWidth = textWidth('W') * keyboardHud.getLimit();
  }

  public CommentOverlayState update()
  { 
    if(discarded) return CommentOverlayState.DISCARDED;

    // Ignore the first frame ( for keyboard input ) 
    if(!firstFrameSkipped)
    {
      firstFrameSkipped = true;
      return CommentOverlayState.NOT_FINISHED;
    }

    handleKeyboard();
    if(Input.keyClicked('x') || Input.keyClicked('X') || submitted)
    {
      return CommentOverlayState.SUBMITTED;
    }

    return CommentOverlayState.NOT_FINISHED;
  }

  public void handleKeyboard()
  {
    commentInput = Keyboard.update(commentInput);
    keyboardHud.value = commentInput;
    keyboardHud.update();
  }

  public String getCommentInput()
  {
    return commentInput;
  }

  public void draw() 
  {
    background(0,0,0,0.3f);
    textSize(32);
    fill(255);
    textAlign(LEFT);
    text("BEZIG MET REACTIE PLAATSEN.", 48, 48);
    text("Reactie: " + commentInput, width/2-textWidth, height/2);

    keyboardHud.draw();
  }

  public void onSubmit(String submittedString)
  {
    submitted = true;
    commentInput = submittedString;
  }

  public void onValueChanged(String value)
  {
    commentInput = value;
  }

  public void onDiscard()
  {
    discarded = true;
  }
}

public enum CommentOverlayState
  {
    DISCARDED,
    NOT_FINISHED,
    SUBMITTED
  }
