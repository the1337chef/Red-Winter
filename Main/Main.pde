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
float peopleSize;
float speed;                   //Player speed
float enemySpeed;              //Russian soldier speed
float direction;               //Initial player direction
int arrowDamage;                //User arrow damage
float arrowSpeed;              //Speed at which arrow projectiles will fly
float arrowSize;
int bulletDamage;
float bulletSpeed;
float bulletSize;
boolean aiming;
boolean shooting;
int timer;
int shootTimer;
Player player;                 //The player character that the user directly controls
HUD hud;                       //Class which retrieves information and displays it for the user
boolean zoneTransition;        //Triggers the fade between zone transitions
boolean saveCompleted = false; //Prompts the screen to say that the user has completed the save
int currentTime;               //Measures time for the "Save Completed" to go away after 5 seconds
float nextPlayerX;             //Player's X position upon a transition to a different zone
float nextPlayerY;             //Player's Y position upon a transition to a different zone
String gameOverStatement = "Mission Failed";      //Text to be displayed at end of game


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
SoundFile theme;
SoundFile siberia;

//Images
PImage menu_background;
PImage background;
PImage zoneGround;
PImage foreground;
PImage horizonView;
PImage cutScene;
PImage playerBottom;
PImage playerTop;
PImage fistTop;
PImage bowTop;
PImage arrow;
PImage bullet;
PImage russianBottom;
PImage russianTop;

PImage hudHealth;
PImage hudEnergy;
PImage hudAmmo;
PImage crosshairs;

//Fonts
PFont menuFont;
//Zones

//Menu
boolean pause;
boolean gameStart;
boolean dead;
//float deadTimer;
boolean exhausted;
float deadTimer;
float timeDead;

Button newGame;
Button continueGame;
Button menuBack;
Button pauseContinue;
Button quitGame;
Button saveGame;

//Weapons
Weapon none;
RangedWeapon bow;

Weapon activeWeapon, previousWeapon, tempWeapon;

//Player movement
boolean mUp, mDown, mLeft, mRight;
boolean meleeOne, meleeTwo;

boolean hitBoxMode;
//boolean btnClicked;

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
ArrayList<Enemy> enemies = new ArrayList<Enemy>();




//Sounds
SoundFile pickupSound;
SoundFile ak47;
SoundFile wounded;
SoundFile buttonHover;
SoundFile buttonClick;
boolean soundPlayed = false;
SoundFile step;
SoundFile floor_step;
SoundFile soundFile;

void setup()
{
  //Screen Resolution
  fullScreen();
  //backgroundImage
  frameRate(60);
  cursor(ARROW);
  noSmooth();
  
  scaler = height / 288.0;
  peopleSize = 48;
  
  //Game state
  gameState = 2; //Start in Menu
  
  //Initial camera position
  cameraX = 0;
  cameraY = 0;
  
  //Save file reader and writer
  loadSave();
  
  //Fonts
  textAlign(CENTER);
  menuFont = createFont("Fonts/BraggadocioRegular.ttf", 32);

  menu_background = loadImage("Menu/menu-temp.png");
  playerBottom = loadImage("Sprites/Amaruq_Sprite_Sheet_Bottom.png");
  fistTop = loadImage("Sprites/Amaruq_Sprite_Sheet_Top.png");
  bowTop = loadImage("Sprites/Amaruq_Sprite_Sheet_Top_Bow.png");
  playerTop = fistTop;
  arrow = loadImage("Sprites/arrow_projectile.png");
  bullet = loadImage("Sprites/bullet_projectile2.png");
  russianBottom = loadImage("Sprites/Soldier_Sprite_Sheet_Bottom.png");
  russianTop = loadImage("Sprites/Soldier_Sprite_Sheet_Top.png");  

  hudHealth = loadImage("Sprites/Heart.png");
  hudEnergy = loadImage("Sprites/Energy.png");
  hudAmmo = loadImage("Sprites/Arrow.png");
  crosshairs = loadImage("Sprites/crosshairs.png");
  //Intro?
  
  //Menu
  textFont(menuFont);
  newGame = new Button(width/1.3, height/9, 300, 75, "NEW GAME", true);
  if(currentZone.equals("null"))
    continueGame = new Button(width/1.3, height/9 + 100, 300, 75, "CONTINUE", false);
  else{
    continueGame = new Button(width/1.3, height/9 + 100, 300, 75, "CONTINUE", true);
    zoneTransition = true;
    //println("t3");
  }
  //menuBack = new Button(width/2, height/2 + height/5, 200, 50, "MAIN MENU", true);
  //pauseContinue = new Button(width/2, height/2, 200, 50, "RESUME", true);
  saveGame = new Button(width/1.3, height/9 + 200, 300, 75, "SAVE", true);
  quitGame = new Button(width/1.3, height/9 + 300, 300, 75, "QUIT", true);
  
  //Options
  
  pause = false;
  dead = false;
  deadTimer = 0;
 
  //Play sounds
  //Menu/ Game music
  soundFile = new SoundFile(this, "SFX/ZoneTransition2.wav");
  soundFile.amp(0.6);
  theme = new SoundFile(this, "SFX/Theme.wav");
  theme.amp(0.8);
  siberia = new SoundFile(this, "SFX/siberia-background.wav");
  siberia.amp(0.2);
  
  
  //Player values
  player = new Player(width/2, height/2, direction, saveHealth, saveStamina, saveTemp, saveAmmo, peopleSize/2, peopleSize/2, "player");
  speed = 4.0;
  enemySpeed = 2.0;
  direction = 0;
  arrowDamage = 100;
  arrowSpeed = 15.0;
  arrowSize = 5;
  bulletDamage = 20;
  bulletSpeed = 10.0;
  bulletSize = 4;
  aiming = false;
  shooting = false;
  timer = 0;
  shootTimer = 0;
  
  //Heads up display
  hud = new HUD(saveHealth, saveStamina, saveTemp, saveAmmo);
  
  bow = new RangedWeapon(arrowDamage, arrowSpeed, "friendly_damage", arrowSize, arrowSize);
  activeWeapon = none;
  previousWeapon = bow;
  hitBoxMode = false;
  
  
  //Sounds
  buttonHover = new SoundFile(this, "SFX/btn_hover.wav");
  buttonHover.amp(.2);
  buttonClick = new SoundFile(this, "SFX/btn_click.wav");
  buttonClick.amp(.5);
  pickupSound = new SoundFile(this, "SFX/pickup.wav");
  pickupSound.amp(1.0);
  ak47 = new SoundFile(this, "SFX/ak47.wav");
  wounded = new SoundFile(this, "SFX/wounded.wav");
  step = new SoundFile(this, "SFX/one-snow-step.wav");
  step.amp(0.3);
  floor_step = new SoundFile(this, "SFX/one-step-floor.wav");
  floor_step.amp(0.4);
  
  //player.display();
  
  
  
  Chapter chapter3 = new Chapter("3");
  Chapter chapter4 = new Chapter("4");
  //Initiallize Chapter Information
  configureChapter(chapter1);
  configureChapter(chapter2);
  configureChapter(chapter3);
  configureChapter(chapter4);
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
      tempWeapon = activeWeapon;
      activeWeapon = previousWeapon;
      previousWeapon = tempWeapon;
      fistTop = playerTop;
      playerTop = bowTop;
      bowTop = fistTop;
    }
    if(key == 'h' || key == 'H')
      hitBoxMode = !hitBoxMode;
      
    if(key == 't' || key == 'T'){
      println("getHealth =" + player.getCurrentHealth());
      println("gameState is " + gameState);
    }
      
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

void mouseMoved() {
  if (gameState == 2) {
    if(newGame.getHighlight() || continueGame.getHighlight() || quitGame.getHighlight() || saveGame.getHighlight()) {
      cursor(HAND);
    }
    else {
      cursor(ARROW); 
    }
  }
}

void mousePressed()
{
  //Menu buttons
  if(gameState == 2)
  {
    buttonClick.play();
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
      theme.stop();
      //Read save file
      gameState = 0;
      loadZone();
      
      //Switch to gameplay at appropriate zone
      
      resetValues();
      //println("reset in continue game");
      noCursor();
    }

    if(quitGame.getHighlight())
    {
      //Quit game
      buttonClick.play();
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
    if(activeWeapon instanceof RangedWeapon && player.getCurrentAmmo() > 0 && mouseButton == LEFT)
    {
       aiming = true;
    }
    //MORE PAUSE;
    if( mouseButton == RIGHT)
    {
      aiming = false;
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
    if(mouseButton == LEFT)
    {
      if(activeWeapon instanceof RangedWeapon && aiming && player.getCurrentAmmo() > 0 && !shooting)
      {
        float angle = mouseAngle();
        float xVector = cos(angle);
        float yVector = sin(angle);
        bow.addProjectile(player.getXPos(), player.getYPos(), xVector, yVector);
        shooting = true;
        player.setCurrentAmmo(player.getCurrentAmmo() - 1);
      }
    }
  }
}

void zoneKeyAdd()
{
}

//DEAD CHECK
boolean checkDead(Character testChar)
{
  boolean deadTest = false;
  if(testChar.getCurrentHealth() <= 0)
  {
    deadTest = true;
    if(testChar instanceof  Player)
    {
      dead = true;  
      enemies.clear();
    }
  }
  return deadTest;
}

void resetValues(){
  cutSceneHalfWay = false;
}

//CORE GAME LOOP
//DRAW FUNCTION
void draw()
{
  if(gameState == 0)
  {
     gamePlay(); 

  
  }
  else if(gameState == 1){
    //println("SubSceneIndex: " + subSceneIndex);
    loadCutScene();
    
  }
  else
    mainMenu();
}