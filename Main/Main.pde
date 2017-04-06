//RED WINTER MAIN
//Main file/ class

//For zone transition
float transparency = 0; //Fade to white
float transparencyIncrement = 17;
float transparency2 = 255; //Fade from white to pic
boolean zoneTransition2 = false; //start the fade to white
String nextZone = "null"; //Zone to transition to
boolean flashBack = false; //Uses the same mechanic as zone transition but changes the fill color
float fillColor = 0; //initially fade to black

//Imports
import processing.sound.*;

//Universal declarations
float scaler;                  //Used to scale the game up from 512x288 to the user's screen resolution
float speed;                   //Player speed
float direction;               //Initial player direction
int knifeDamage;               //User knife damage value
float knifeReach;              //Variable determining how far the knife can reach, used for knife
int bowDamage;                 //User arrow damage
float arrowSpeed;              //Speed at which arrow projectiles will fly
boolean aiming;
Player player;                 //The player character that the user directly controls
HUD hud;                       //Class which retrieves information and displays it for the user
boolean zoneTransition;        //Triggers the fade between zone transitions
boolean saveCompleted = false; //Prompts the screen to say that the user has completed the save
int currentTime;               //Measures time for the "Save Completed" to go away after 5 seconds
float nextPlayerX;             //Player's X position upon a transition to a different zone
float nextPlayerY;             //Player's Y position upon a transition to a different zone



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
String currentChapter;
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
PImage foreground;
PImage horizonView;
PImage cutScene;
PImage playerBottom;
PImage playerTop;

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
Button saveGame;

//Weapons
Weapon none;
RangedWeapon bow;
//MeleeWeapon knife;

Weapon activeWeapon, previousWeapon, temp;

//Player movement
boolean mUp, mDown, mLeft, mRight;
boolean meleeOne, meleeTwo;

boolean hitBoxMode;

//Walls
//Changes from zone to zone
ArrayList<Wall> walls = new ArrayList<Wall>();


//Projectile Spawners
ArrayList<Projectile> projectiles = new ArrayList<Projectile>();

//Pickups
ArrayList<Pickup> pickups = new ArrayList<Pickup>();

//Zone Transitions
ArrayList<Hitbox> transitions = new ArrayList<Hitbox>();

//Enemies
//ArrayList<Enemy> enemies = new ArrayList<Enemy>();

//Sounds
SoundFile pickupSound;

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

  try
  {
    currentChapter = saveReader.readLine().substring(8);
    currentZone = saveReader.readLine().substring(5);
    nextPlayerX = Float.parseFloat(saveReader.readLine().substring(5));
    nextPlayerY = Float.parseFloat(saveReader.readLine().substring(5));
    nextZone = currentZone;
    saveHealth = Float.parseFloat(saveReader.readLine().substring(7));
    saveStamina = Float.parseFloat(saveReader.readLine().substring(8));
    saveTemp = Float.parseFloat(saveReader.readLine().substring(5));
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
    currentChapter = "1";
    currentZone = "null";
    nextPlayerX = 0;
    nextPlayerY = 0;
    saveHealth = 0;
    saveStamina = 0;
    saveTemp = 0;
    saveAmmo = 0;
    last_cutscene = "0";
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
  menuFont = loadFont("Fonts/LucidaSans-TypewriterBold-24.vlw");
  
  //Images
  background = loadImage("ETC/major_cutscene_test_32_low_res.png");
  playerBottom = loadImage("Sprites/Amaruq_Sprite_Sheet_Bottom.png");
  playerTop = loadImage("Sprites/Amaruq_Sprite_Sheet_Top.png");
  
  //Intro?
  
  //Menu
  newGame = new Button(width/2, height/2, 200, 50, "NEW GAME", true);
  if(currentZone.equals("null"))
    continueGame = new Button(width/2, height/2 - height/5, 200, 50, "CONTINUE", false);
  else{
    continueGame = new Button(width/2, height/2 - height/5, 200, 50, "CONTINUE", true);
    zoneTransition = true;
  }
  //menuBack = new Button(width/2, height/2 + height/5, 200, 50, "MAIN MENU", true);
  //pauseContinue = new Button(width/2, height/2, 200, 50, "RESUME", true);
  quitGame = new Button(width/2, height/2 + 2*height/5, 200, 50, "QUIT", true);
  saveGame = new Button(width/2, height/2 + height/5, 200, 50, "SAVE", true);
  
  //Options
  
  pause = false;
  gameStart = true; //SWITCH TO FALSE WHEN MENU IS ADDED
  dead = false;
  deadTimer = 0;
  
  //Fades
 
  //Play sounds
  //Menu/ Game music
  
  
  //Player values
  player = new Player(width/2, height/2, direction, saveHealth, saveStamina, saveTemp, saveAmmo, 20, 20, "player");
  speed = 4.0;
  direction = 0;
  knifeDamage = 50;
  knifeReach = 70;
  bowDamage = 100;
  arrowSpeed = 15.0;
  aiming = false;
  
  //Heads up display
  hud = new HUD(saveHealth, saveStamina, saveTemp, saveAmmo);
  
  bow = new RangedWeapon(bowDamage, arrowSpeed, "friendly_damage", 20, 20);
  //knife = new MeleeWeapon(knifeDamage, 0, 0, knifeReach, 400, true);
  activeWeapon = none;
  previousWeapon = bow;
  meleeOne = false;
  meleeTwo = false;
  hitBoxMode = false;
  
  
  //Sounds
  pickupSound = new SoundFile(this, "SFX/pickup.wav");
  pickupSound.amp(1.0);

  
  //Adding bow to projectileSpawners
  //projectileSpawners.add(bow);
  
  //stamina20 = new StaminaPickup(3*width/4, height/4, 10, 10, 20);
  //pickups.add(stamina20);
  
  player.display();
  
  //ENEMY INITIALIZATION
  
  //Initiallize Chapter Information
  configureChapter(chapter1);
  configureChapter(chapter2);
    
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
      temp = activeWeapon;
      activeWeapon = previousWeapon;
      previousWeapon = temp;
    }
    if(key == 'h' || key == 'H')
      hitBoxMode = !hitBoxMode;
      
    if(key == 't' || key == 'T')
      zoneTransition = true;
      
    if(key == 'c' || key == 'C'){
      gameState = 1;
      //println("reset in C");
      resetValues();
    }
    if(key == 'u'){
      println("walls:");
      for(int i = 0; i < walls.size(); i++){
        walls.get(i).print();
      }
      println("transitions:");
      for(int i = 0; i < transitions.size(); i++){
        transitions.get(i).print();
      }    
    }
     
    if(key == ' ')
      if(gameState == 1){
        nextSubScene();
      }
      
    if(key == 'q' || key == 'Q'){
      println("x = " + nextPlayerX);
      println("y = " + nextPlayerY);
    }

      
    if(key == 'p' || key == 'P'){//pause
      pause = true;
      gameState = 2;
     // resetValues();
    }
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
      newSave();
      //println("SubSceneIndex: " + subSceneIndex);
      //Play next cutscene
      //Play cut
      gameState = 1;
      //println("reset in mousePRessed");
      resetValues();
    }
    if(continueGame.getHighlight())
    {
      //Read save file
      loadZone();
      
      //Switch to gameplay at appropriate zone
      gameState = 0;
      resetValues();
      //println("reset in continue game");
      cursor(CROSS);
    }

    if(quitGame.getHighlight())
    {
      //Quit game
      exit();
    }
    
    if(saveGame.getHighlight())
    {
      save();
    }
    
  }
  //IN-GAME
  else if(gameState == 0)
  {
    if(mouseButton == LEFT)
    {
      if(activeWeapon instanceof RangedWeapon && aiming)
      {
        float angle = mouseAngle();
        float xVector = cos(angle);
        float yVector = sin(angle);
        bow.addProjectile(player.getXPos(), player.getYPos(), xVector, yVector);
      }
    }
    //MORE PAUSE;
    
    if(activeWeapon instanceof RangedWeapon && mouseButton == RIGHT)
    {
       aiming = true;
    }
  }
  //CUTSCENE
  else{
    nextSubScene();
  }
}

void mouseReleased()
{
  if(gameState == 0 && activeWeapon instanceof RangedWeapon)
  {
    if(mouseButton == RIGHT)
    {
      aiming = false;
    }
  }
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


void resetValues(){
  cutSceneHalfWay = false;
}

//CORE GAME LOOP
//DRAW FUNCTION
void draw()
{
  if(gameState == 0){
    gamePlay();
  }
  else if(gameState == 1){
    //println("SubSceneIndex: " + subSceneIndex);
    loadCutScene();
    
  }
  else
    mainMenu();
}