static class Config {
  
  final static PVector PLAYER_SIZE = new PVector(100, 100);
  final static int MIN_STARTING_CHUNKS = 4;
  final static float CHUNK_BOTTOM_OFFSET = 50;
  final static float DEFAULT_GROUP_WIDTH = 1000; //Changing this will result in chunks clipping in eachother. When you change this also change the chunks in the chunks.json file.
  final static int DEFAULT_CAMERA_MOVEMENT_SPEED = 5;
  final static float CAMERA_SPEED_UP_SPEED = 0.05;
  
  final static float PLAYER_BOTTOM_OFFSET = 300;
  final static float PLAYER_JUMP_POWER = -25f;
  final static float PLAYER_JUMP_GRAVITY = 1f;
  final static float PLAYER_SPEED = 5;
  final static float PLAYER_START_HP = 100;
  final static float PLAYER_JUMP_OFFSET = 120;
  final static float SHIELD_OFFSET_X = 100;
  final static float SHIELD_WIDTH = 10;
  final static float SHIELD_HEIGHT = 100;

  //Directions used for collisions
  final static float LEFT = -1;
  final static float RIGHT = 1;
  final static float UP = 1;
  final static float DOWN = -1;
}
