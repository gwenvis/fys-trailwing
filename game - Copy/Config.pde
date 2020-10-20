static class Config {
  final static int MIN_STARTING_CHUNKS = 3;
  final static float CHUNK_BOTTOM_OFFSET = 100;
  final static float DEFAULT_GROUP_WIDTH = 1000; //Changing this will result in chunks clipping in eachother. When you change this also change the chunks in the chunks.json file.
  final static int CAMERA_MOVEMENT_SPEED = 5;
  
  final static float PLAYER_BOTTOM_OFFSET = 200;
  final static float PLAYER_JUMP_POWER = -25f;
  final static float PLAYER_JUMP_GRAVITY = 0.9f;
  final static float PLAYER_SPEED = 5;
  final static float PLAYER_START_HP = 100;
  final static float PLAYER_JUMP_OFFSET = 120;
  final static float SHIELD_OFFSET_X = 100;
  final static float SHIELD_WIDTH = 10;
  final static float SHIELD_HEIGHT = 100;
}
