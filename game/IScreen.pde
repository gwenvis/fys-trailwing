interface IScreen {
  public void setup();
  public void draw();
  // this probably won't be used because Java uses a GC, but just for cause.
  public void destroy();
}
