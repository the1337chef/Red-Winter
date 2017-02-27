//RED WINTER MAIN
//Main file/ class

//Imports
import processing.sound.*;
import controlP5.*;

//Universal declarations
float speed;
float direction;
int knifeDamage;
float knifeReach;
int bowDamage;
float arrowSpeed;
Player player;
HUD hud;
int chapterKeys;
int reqKeys;

/* Game State Tracker
 * 0 = Gameplay
 * 1 = Cutscene
 * 2 = Menu
 */
int gameState;

//Fade trackers

//Sound

//Images
PImage background;
PImage zoneGround;

//Fonts
PFont menuFont;
//Zones

//Menu
boolean pause;
boolean gameStart;
boolean dead;
float deadTimer;

Button newGame;
Button continueGame;
Button menuBack;
Button pauseContinue;
Button quitGame;

//Weapons
/*Weapon none;
RangedWeapon bow;
MeleeWeapon knife;

Weapon activeWeapon, previousWeapon, temp;*/

//Player movement
boolean mUp, mDown, mLeft, mRight;
boolean meleeOne, meleeTwo;

boolean hitBoxMode;

//Walls
//Changes from zone to zone
ArrayList<Wall> walls = new ArrayList<Wall>();
Wall testWall;

//Projectile Spawners
//ArrayList<RangedWeapon> projectileSpawners = new ArrayList<RangedWeapon>();

//Pickups
ArrayList<Pickup> pickups = new ArrayList<Pickup>();

//Enemies
//ArrayList<Enemy> enemies = new ArrayList<Enemy>();

void setup()
{
  //Screen Resolution
  fullScreen();
  //backgroundImage
  frameRate(60);
  cursor(ARROW);
  
  //Game state
  gameState = 2; //Start in Menu
  
  //Fonts
  textAlign(CENTER);
  menuFont = loadFont("LucidaSans-TypewriterBold-24.vlw");
  
  //Images
  background = loadImage("major_cutscene_test_32_low_res.png");
  
  //Intro?
  
  //Menu
  newGame = new Button(width/2, height/2, 200, 50, "NEW GAME", true);
  continueGame = new Button(width/2, height/2 - height/5, 200, 50, "CONTINUE", false);
  menuBack = new Button(width/2, height/2 + height/5, 200, 50, "MAIN MENU", true);
  pauseContinue = new Button(width/2, height/2, 200, 50, "RESUME", true);
  quitGame = new Button(width/2, height/2 + 2*height/5, 200, 50, "QUIT", true);
  
  //Options
  
  pause = false;
  gameStart = true; //SWITCH TO FALSE WHEN MENU IS ADDED
  dead = false;
  deadTimer = 0;
  
  //Zone values
  chapterKeys = 0;
  reqKeys = 1;
  
  //Fades
  
  //Play sounds
  //Menu/ Game music
  
  
  //Player values
  player = new Player(width/2, height/2, direction, 100, 32, 32, "player");
  speed = 5.0;
  direction = 0;
  knifeDamage = 50;
  knifeReach = 70;
  bowDamage = 100;
  arrowSpeed = 15.0;
  
  //Heads up display
  hud = new HUD(100, 100, 100, 0);
  
  //bow = new RangedWeapon(bowDamage, arrowSpeed, true);
  //knife = new MeleeWeapon(knifeDamage, 0, 0, knifeReach, 400, true);
  //activeWeapon = none;
  //beviousWeapon = bow;
  meleeOne = false;
  meleeTwo = false;
  hitBoxMode = false;
  
  //Test wall
  testWall = new Wall(width/4, height/2, 32, 128, 0);
  walls.add(testWall);
  
  //Adding bow to projectileSpawners
  //projectileSpawners.add(bow);
  
  //stamina20 = new StaminaPickup(3*width/4, height/4, 10, 10, 20);
  //pickups.add(stamina20);
  
  player.display();
  
  //ENEMY INITIALIZATION
  
}

//Keyboard
void keyReleased()
{
  //MENU SHIT
  
  //CONTROLS
  if(key == CODED)
  {
    if(keyCode == UP)
      mUp = false;
    if(keyCode == DOWN)
      mDown = false;
    if(keyCode == LEFT)
      mLeft = false;
    if(keyCode == RIGHT)
      mRight = false;
  }
  else
  {
    if(key == 'W' || key == 'w')
      mUp = false;
    if(key == 'S' || key == 's')
      mDown = false;
    if(key == 'A' || key == 'a')
      mLeft = false;
    if(key == 'D' || key == 'd')
      mRight = false;
      
    //Weapon switch
    if(key == 'f' || key == 'F')
    {
      //temp = activeWeapon;
      //activeWeapon = previousWeapon;
      //previousWeapon = temp;
    }
    if(key == 'h' || key == 'H')
      hitBoxMode = !hitBoxMode;
  }
}

//Mouse

void mousePressed()
{
  //Menu buttons
  if(gameState == 2)
  {
    //New game button
    if(newGame.getHighlight())
    {
      //Write/ rewrite save file
      
      //Play next cutscene
      gameState = 1;
    }
    
    if(continueGame.getHighlight())
    {
      //Read save file
      
      //Switch to gameplay at appropriate zone
      gameState = 0;
      cursor(CROSS);
    }
    
    if(quitGame.getHighlight())
    {
      //Quit game
      exit();
    }
  }
  
  //IN-GAME
  if(gameState == 0)
  {/*
    if(mouseButton == LEFT)
    {
      if(activeWeapon instanceof RangedWeapon)
      {
        float angle = mouseAngle();
        float xVector = cos(angle);
        float yVector = sin(angle);
        bow.addProjectile(player.getXPos(), player.getYPos(), xVector, yVector, 60, 10);
      }
    }*/
    //MORE PAUSE;
    
    if(mouseButton == RIGHT)
    {
       //WEAPON AIM 
    }
  }
}

//Returns the angle in radians between the player and the current mouse position
float mouseAngle()
{
  return atan2(mouseY-player.getYPos(), mouseX-player.getXPos());
}

//COLLISION DETECTION
//X-AXIS
boolean xCollision(Hitbox hBox1, Hitbox hBox2, float xChange)
{
  if(hBox2.getHeight() > hBox1.getHeight())        //Adjustment for size difference between hitboxes
  {
    Hitbox temp = hBox1;
    hBox1 = hBox2;
    hBox2 = temp;
  }
  if((hBox1.getYPos() + hBox1.getHeight()/2 >= hBox2.getYPos() - hBox2.getHeight()/2 &&
    hBox1.getYPos() - hBox1.getHeight()/2 <= hBox2.getYPos() + hBox2.getHeight()/2) &&
    (hBox1.getXPos() + hBox1.getWidth()/2 >= hBox2.getXPos() - hBox2.getWidth()/2 + xChange &&
    hBox1.getXPos() - hBox1.getWidth()/2 <= hBox2.getXPos() + hBox2.getWidth()/2 + xChange))
    {
      return true;
    }
  else
    return false;
}

//Y-AXIS
boolean yCollision(Hitbox hBox1, Hitbox hBox2, float yChange)
{
  if(hBox2.getWidth() > hBox1.getWidth())        //Adjustment for size difference between hitboxes
  {
    Hitbox temp = hBox1;
    hBox1 = hBox2;
    hBox2 = temp;
  }
  if((hBox1.getXPos() + hBox1.getWidth()/2 >= hBox2.getXPos() - hBox2.getWidth()/2 &&
    hBox1.getXPos() - hBox1.getWidth()/2 <= hBox2.getXPos() + hBox2.getWidth()/2) &&
    (hBox1.getYPos() + hBox1.getHeight()/2 >= hBox2.getYPos() - hBox2.getHeight()/2 + yChange &&
    hBox1.getYPos() - hBox1.getHeight()/2 <= hBox2.getYPos() + hBox2.getHeight()/2 + yChange))
    {
      return true;
    }
  else
    return false;
}

void zoneKeyAdd()
{
  chapterKeys++;
  if(chapterKeys >= reqKeys)
  {}
}

//DEAD CHECK
void deadCheck(Character testChar)
{
  if(testChar.getCurrentHealth() <= 0)
  {
    //Death sound
    //Reset/ Load to checkpoint
    dead = true;
  }
}

//CORE GAME LOOP
//DRAW FUNCTION
void draw()
{
  if(gameState == 0)
    gamePlay();
  else if(gameState == 1)
    cutscene();
  else
    mainMenu();
}