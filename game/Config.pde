static class Config {

  final static int MIN_STARTING_CHUNKS = 4;
  final static float CHUNK_BOTTOM_OFFSET = 50;
  final static float DEFAULT_GROUP_WIDTH = 1000; //Changing this will result in chunks clipping in eachother. When you change this also change the chunks in the chunks.json file.
  final static int DEFAULT_CAMERA_MOVEMENT_SPEED = 5;
  final static float CAMERA_SPEED_UP_SPEED = 0.02;

  final static int MAX_CHUNCK_LEVEL = 2;

  //Directions used for collisions
  final static float LEFT = -1;
  final static float RIGHT = 1;
  final static float UP = 1;
  final static float DOWN = -1;
  final static float POWERUP_WIDTH = 100;
  final static float POWERUP_HEIGHT = 100;
  final static float POWERUP_SPAWN_CHANCE = 100/4;
  final static float POWERUP_ACTIVE_TIMER = 5.5f; // in seconds
  final static float POWERUP_JUMP_BOOST = 2f; // multiplies jump by this
  final static String[] POWERUP_SPRITENAMES = new String[] {
    "invincibility.png", 
    "super_jump.png"
  };

  //Player
  final static PVector PLAYER_SIZE = new PVector(75, 75);

  final static int MAX_COIN_AMOUNT = 10;

  final static int MAX_SHIELD_AMOUNT = 10;
  final static int SHIELD_START_AMOUNT = 2;
  final static int SHIELD_START_DURABILITY = 3;

  final static int SCREEN_CALC = 100;
  final static int SCREEN_CALC_LEFT = 20;
  final static int SCREEN_CALC_RIGHT = 80;

  final static int MAX_ARMOUR_LEVEL = 9;

  final static int DIVIDE_IN_HALF = 2;
  final static int SPEED_UP_COOLDOWN = 3000;
  final static float PLAYER_BOTTOM_OFFSET = 125;
  final static float PLAYER_SPEED_UP = .8F;
  final static float PLAYER_JUMP_POWER = -15f;
  final static float PLAYER_JUMP_GRAVITY = 0.25f;
  final static float PLAYER_SPEED = 5;
  final static float PLAYER_MAX_SHIELD_AMOUNT = 5;
  final static float PLAYER_JUMP_OFFSET = 120; 

  //Player class used particlesystem  
  final static int POS_CALC = 2;
  final static int COLOUR_WHITE = 255;  
  final static int HIT_SHIELD_OFFSET = 3;

  final static int ESTIMATED_PARTICLE_HEIGHT = 10;
  final static int ESTIMATED_DISTANCE_SHIELD_PARTICLE = 15;
  final static int HIT_START_COLOUR_R = 102;
  final static int HIT_START_COLOUR_G = 51;
  final static int HIT_START_COLOUR_B = 0;
  final static int HIT_END_COLOUR_R = 153;
  final static int HIT_END_COLOUR_G = 76;
  final static int HIT_END_COLOUR_B = 0;

  //Enemy
  final static int FIREBALL_STARTING_TIME = 3200;

  //Achievement database
  final static int ACHIEVEMENT_AMOUNT = 4;  
  final static int ACTIVE = 1;  
  final static int NON_ACTIVE = 0;

  final static String DATE = String.valueOf(year())+"-"+String.valueOf(month()+"-"+String.valueOf(day()));

  //Particle
  final static int SPEED_CORRECTOR = 2;  
  final static int FIRE_HEIGHT_CORRECTOR = 1;  
  final static int HIT_SPEED_CORRECTOR = 1; 
  final static int HIT_SIZE_CORRECTOR = 5;

  final static int ALPHA_VISIBILITY_CALCULATOR = 2;
  final static int ANGLE_CALC = 3;
  final static int VISIBILITY_CALCULATOR = 30;
  final static int ZERO = 0;
  final static int DIRECTION_CHANGE = -1;
  final static int COLOURDIF_CALCULATOR = 25;  

  final static float ALPHA_VISIBILITY_START = 255; 
  final static float VISIBILITY_START_CALCULATOR = 32;  
  final static float START_SPEED = -2.5;  
  final static float GRAVITY = 1.2;  
  final static float LAND_DUST_SPEED = 0.05;  
  final static float ANGLE_CHANGE = 0.06;

  //Particlesystem
  final static int HIT_PARTICLE_AMOUNT = 3;
  final static int LANDDUST_PARTICLE_AMOUNT = 7;
  final static int FIREBALL_PARTICLE_AMOUNT = 10;

  //Comment database
  final static int MAX_COMMENT_LOAD_DISTANCE = 500;
}
