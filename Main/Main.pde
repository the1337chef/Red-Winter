//RED WINTER MAIN
//Main file/ class

//For zone transition
float transparency = 0; //Fade to white
float transparencyIncrement = 5;
float transparency2 = 255; //Fade from white to pic
boolean zoneTransition2 = false; //start the fade to white

//Imports
//import processing.sound.*;

//Universal declarations
float scaler;                  //Used to scale the game up from 512x288 to the user's screen resolution
float speed;                   //Player speed
float direction;               //Initial player direction
int knifeDamage;               //User knife damage value
float knifeReach;              //Variable determining how far the knife can reach, used for knife hitbox
int bowDamage;                 //User arrow damage
float arrowSpeed;              //Speed at which arrow projectiles will fly
Player player;                 //The player character that the user directly controls
HUD hud;                       //Class which retrieves information and displays it for the user
boolean zoneTransition;        //Triggers the fade between zone transitions

/*
 * Camera X and Y determine the position the player's see of the larger map.
 * Based off of the top-left corner of the screen and image.
 * X can be between 0 and 608
 * Y can be between 0 and 266
 */
float cameraX;
float cameraY;

//Save and checkpoint relevant declarations
BufferedReader saveReader;
PrintWriter saveWriter;
String currentZone;
float saveHealth;
float saveStamina;
float saveTemp;
int saveAmmo;
String last_cutscene;
int dynamite;
int detonator;
int rope;
int collar;
int seal1;
int seal2;
int whale;
int sap;


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
  noSmooth();
  
  scaler = height / 288.0;
  
  //Game state
  gameState = 2; //Start in Menu
  
  //Initial camera position
  cameraX = 0;
  cameraY = 0;
  
  //Save file reader and writer
  saveReader = createReader("save.txt");
  saveWriter = createWriter("save.txt");
  try
  {
    currentZone = saveReader.readLine().substring(5);
    saveHealth = Integer.parseInt(saveReader.readLine().substring(7));
    saveStamina = Integer.parseInt(saveReader.readLine().substring(8));
    saveTemp = Integer.parseInt(saveReader.readLine().substring(5));
    saveAmmo = Integer.parseInt(saveReader.readLine().substring(5));
    last_cutscene = saveReader.readLine().substring(14);
    dynamite = Integer.parseInt(saveReader.readLine().substring(9));
    detonator = Integer.parseInt(saveReader.readLine().substring(10));
    rope = Integer.parseInt(saveReader.readLine().substring(5));
    collar = Integer.parseInt(saveReader.readLine().substring(7));
    seal1 = Integer.parseInt(saveReader.readLine().substring(6));
    seal2 = Integer.parseInt(saveReader.readLine().substring(6));
    whale = Integer.parseInt(saveReader.readLine().substring(6));
    sap = Integer.parseInt(saveReader.readLine().substring(4));
  }
  catch(IOException e)
  {
    currentZone = "zone_null";
    saveHealth = 0;
    saveStamina = 0;
    saveTemp = 0;
    saveAmmo = 0;
    last_cutscene = "null";
    dynamite = 0;
    detonator = 0;
    rope = 0;
    collar = 0;
    seal1 = 0;
    seal2 = 0;
    whale = 0;
    sap = 0;
    e.printStackTrace();
  }
  
  
  //Fonts
  textAlign(CENTER);
  menuFont = loadFont("LucidaSans-TypewriterBold-24.vlw");
  
  //Images
  background = loadImage("major_cutscene_test_32_low_res.png");
  
  //Intro?
  
  //Menu
  newGame = new Button(width/2, height/2, 200, 50, "NEW GAME", true);
  if(currentZone.equals("null"))
    continueGame = new Button(width/2, height/2 - height/5, 200, 50, "CONTINUE", false);
  else
    continueGame = new Button(width/2, height/2 - height/5, 200, 50, "CONTINUE", true);
  menuBack = new Button(width/2, height/2 + height/5, 200, 50, "MAIN MENU", true);
  pauseContinue = new Button(width/2, height/2, 200, 50, "RESUME", true);
  quitGame = new Button(width/2, height/2 + 2*height/5, 200, 50, "QUIT", true);
  
  //Options
  
  pause = false;
  gameStart = true; //SWITCH TO FALSE WHEN MENU IS ADDED
  dead = false;
  deadTimer = 0;
  
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
      
    if(key == 't' || key == 'T')
      zoneTransition = true;
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
      //gameState = 1;
    }
    
    if(continueGame.getHighlight())
    {
      //Read save file
      switch(currentZone)
      {
       case "Crash_1":
         //Crash_1 Method
         break;
       //etc.
       case "test":
         testZone();
         break;
       case "test_2":
         testZone2();
         break;
       default:
         throw new IllegalArgumentException("Invalid zone name: " + currentZone);
      }
      
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
  {
    
    
    /*
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
  float yVar;
  if(player.getYPos() < 144)
    yVar = height/2 - (((144-player.getYPos())/144) * height/2);
  else if(player.getYPos() > 410)
    yVar = height/2 + (((player.getYPos()-410)/144) * height/2);
  else
    yVar = height/2;
    
  float xVar;
  if(player.getXPos() < 256)
    xVar = width/2 - ((width/2) * ((256-player.getXPos())/256));
  else if(player.getXPos() > 864)
    xVar = width/2 + ((width/2) * ((player.getXPos()-864)/256));
  else
    xVar = width/2;
  return atan2(mouseY-yVar, mouseX-xVar);
}

//COLLISION DETECTION
//X-AXIS
boolean xCollision(Hitbox hBox1, Hitbox hBox2, float xChange)
{
  if(hBox2.getHeight() > hBox1.getHeight())        //Adjustment for size difference between hitboxes
  {
    Hitbox temp = hBox1;
    hBox1 = hBox2; //did you switch so the one with the larger height is hBox1
    hBox2 = temp;
    //xChange = -xChange;
  }
  //the above will affect the xchange because it is assigned to the wrong box
  if((hBox1.getYPos() + hBox1.getHeight()/2 >= hBox2.getYPos() - hBox2.getHeight()/2) && //top of first is bigger than the bottom of second
    (hBox1.getYPos() - hBox1.getHeight()/2 <= hBox2.getYPos() + hBox2.getHeight()/2) && //bottom of first is smaller than the top of the second
    (hBox1.getXPos() + hBox1.getWidth()/2 >= hBox2.getXPos() - hBox2.getWidth()/2 + xChange) && //right of first is larger than left of second with change
    (hBox1.getXPos() - hBox1.getWidth()/2 <= hBox2.getXPos() + hBox2.getWidth()/2 + xChange)) //left of first will be smaller than right of second with change 
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
    //yChange = -yChange;
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
  if(gameState == 0){
    gamePlay();
  }
  else if(gameState == 1)
    cutscene();
  else
    mainMenu();
}