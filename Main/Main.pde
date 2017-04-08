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
SoundFile theme;
SoundFile siberia;

//Images
PImage background;
PImage zoneGround;
PImage foreground;
PImage horizonView;
PImage cutScene;
PImage playerBottom;
PImage playerTop;
PImage fistTop;
PImage bowTop;
PImage russianBottom;
PImage russianTop;

//Fonts
PFont menuFont;
//Zones

//Menu
boolean pause;
boolean gameStart;
boolean dead;
float deadTimer;
float timeDead;

Button newGame;
Button continueGame;
Button menuBack;
Button pauseContinue;
Button quitGame;
Button saveGame;
Button deathContinue;

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
ArrayList<Enemy> enemies = new ArrayList<Enemy>();


//Sounds
SoundFile pickupSound;
SoundFile step;
SoundFile soundFile;
boolean soundPlayed = false;

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
  reload();
  
  
  //Fonts
  textAlign(CENTER);
  menuFont = loadFont("Fonts/LucidaSans-TypewriterBold-24.vlw");
  
  //Images
  background = loadImage("ETC/major_cutscene_test_32_low_res.png");
  playerBottom = loadImage("Sprites/Amaruq_Sprite_Sheet_Bottom.png");
  fistTop = loadImage("Sprites/Amaruq_Sprite_Sheet_Top.png");
  bowTop = loadImage("Sprites/Amaruq_Sprite_Sheet_Top_Bow.png");
  playerTop = fistTop;
  russianBottom = loadImage("Sprites/Soldier_Sprite_Sheet_Bottom.png");
  russianTop = loadImage("Sprites/Soldier_Sprite_Sheet_Top.png");  

  //Intro?
  
  //Menu
  newGame = new Button(width/2, height/2, 200, 50, "NEW GAME", true);
  if(currentZone.equals("null")){
    continueGame = new Button(width/2, height/2 - height/5, 200, 50, "CONTINUE", false);
    println("current zone is null");
  }
    
  else{
    continueGame = new Button(width/2, height/2 - height/5, 200, 50, "CONTINUE", true);
    zoneTransition = true;
    println("current zone is NOT null");
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
  timeDead = 0;
  
  //Fades
 
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
  arrowSpeed = 30.0;
  arrowSize = 5;
  bulletDamage = 20;
  bulletSpeed = 10.0;
  bulletSize = 4;
  aiming = false;
  
  //Heads up display
  hud = new HUD(saveHealth, saveStamina, saveTemp, saveAmmo);
  
  bow = new RangedWeapon(arrowDamage, arrowSpeed, "friendly_damage", arrowSize, arrowSize);
  activeWeapon = none;
  previousWeapon = bow;
  meleeOne = false;
  meleeTwo = false;
  hitBoxMode = false;
  
  
  //Sounds
  pickupSound = new SoundFile(this, "SFX/pickup.wav");
  pickupSound.amp(1.0);
  step = new SoundFile(this, "SFX/one-snow-step.wav");
  step.amp(0.3);
  
  //player.display();
  
  
  //Initiallize Chapter Information
  configureChapter(chapter1);
  configureChapter(chapter2);
    
}

void reload()
{
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
    deadTimer = millis();
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
      fistTop = playerTop;
      playerTop = bowTop;
      bowTop = fistTop;
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



//DEAD CHECK
boolean checkDead(Character testChar)
{
  
  if(testChar.getCurrentHealth() <= 0)
  {
  
  if(testChar instanceof  Player)
  {
    dead = true;  
    enemies.clear(); 
  }
}
     return dead;
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
     if(dead == true)
     {
       float temptime = deadTimer;
       deadTimer = millis();
       timeDead += (deadTimer - temptime);  
       speed = 0;
       
       if(timeDead >= 10000)
       {         
            //Switch to gameplay at appropriate zone
            reload();
            println(currentZone);
            println(nextZone);
            timeDead = 0;
            deadTimer = 0;
            gameState = 2;
       }
     
     }
  
  }
  else if(gameState == 1){
    //println("SubSceneIndex: " + subSceneIndex);
    loadCutScene();
    
  }
  else
    mainMenu();
}
