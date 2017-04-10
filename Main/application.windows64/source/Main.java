import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.sound.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Main extends PApplet {

//RED WINTER MAIN
//Main file/ class

//For zone transition
float transparency = 0; //Fade to white
float transparencyIncrement = 17;
float transparency2 = 255; //Fade from white to pic
boolean zoneTransition2 = false; //start the fade to white
String nextZone = "null"; //Zone to transition to
boolean flashBack = false; //Uses the same mechanic as zone transition but changes the fill color
boolean killTrigger;      //Kills Dragovich
float fillColor = 0; //initially fade to black

//Imports


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
boolean exhausted;
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
SoundFile death;
SoundFile buttonHover;
SoundFile buttonClick;
boolean soundPlayed = false;
SoundFile step;
SoundFile floor_step;
SoundFile soundFile;

public void setup()
{
  //Screen Resolution
  
  //backgroundImage
  frameRate(60);
  
  
  scaler = height / 288.0f;
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
  newGame = new Button(width/1.3f, height/9, 300, 75, "NEW GAME", true);
  if(currentZone.equals("null"))
    continueGame = new Button(width/1.3f, height/9 + 100, 300, 75, "CONTINUE", false);
  else{
    continueGame = new Button(width/1.3f, height/9 + 100, 300, 75, "CONTINUE", true);
    zoneTransition = true;
    //println("t3");
  }
  //menuBack = new Button(width/2, height/2 + height/5, 200, 50, "MAIN MENU", true);
  //pauseContinue = new Button(width/2, height/2, 200, 50, "RESUME", true);
  saveGame = new Button(width/1.3f, height/9 + 200, 300, 75, "SAVE", true);
  quitGame = new Button(width/1.3f, height/9 + 300, 300, 75, "QUIT", true);
  
  //Options
  
  pause = false;
  dead = false;
  //deadTimer = 0;
 
  //Play sounds
  //Menu/ Game music
  soundFile = new SoundFile(this, "SFX/ZoneTransition2.wav");
  soundFile.amp(0.6f);
  theme = new SoundFile(this, "SFX/Theme.wav");
  theme.amp(0.8f);
  siberia = new SoundFile(this, "SFX/siberia-background.wav");
  siberia.amp(0.2f);
  
  
  //Player values
  player = new Player(width/2, height/2, direction, saveHealth, saveStamina, saveTemp, saveAmmo, peopleSize/2, peopleSize/2, "player");
  speed = 4.0f;
  enemySpeed = 2.0f;
  direction = 0;
  arrowDamage = 100;
  arrowSpeed = 15.0f;
  arrowSize = 5;
  bulletDamage = 20;
  bulletSpeed = 10.0f;
  bulletSize = 4;
  aiming = false;
  shooting = false;
  timer = 0;
  shootTimer = 0;
  
  //Heads up display
  hud = new HUD(saveHealth, saveStamina, saveTemp, saveAmmo);
  none = new Weapon();
  bow = new RangedWeapon(arrowDamage, arrowSpeed, "friendly_damage", arrowSize, arrowSize);
  activeWeapon = none;
  previousWeapon = bow;
  hitBoxMode = false;
  killTrigger = false;
  
  
  //Sounds
  buttonHover = new SoundFile(this, "SFX/btn_hover.wav");
  buttonHover.amp(.2f);
  buttonClick = new SoundFile(this, "SFX/btn_click.wav");
  buttonClick.amp(.5f);
  pickupSound = new SoundFile(this, "SFX/pickup.wav");
  pickupSound.amp(1.0f);
  ak47 = new SoundFile(this, "SFX/ak47.wav");
  wounded = new SoundFile(this, "SFX/wounded.wav");
  death = new SoundFile(this, "SFX/death.wav");
  step = new SoundFile(this, "SFX/one-snow-step.wav");
  step.amp(0.3f);
  floor_step = new SoundFile(this, "SFX/one-step-floor.wav");
  floor_step.amp(0.4f);
  
  //player.display();
  
  
  
  Chapter chapter3 = new Chapter("3");
  Chapter chapter4 = new Chapter("4");
  Chapter chapter5 = new Chapter("5");
  //Initiallize Chapter Information
  configureChapter(chapter1);
  configureChapter(chapter2);
  configureChapter(chapter3);
  configureChapter(chapter4);
  configureChapter(chapter5);
}

//Keyboard
public void keyReleased()
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
    /*if(key == 'f' || key == 'F')
    {
      tempWeapon = activeWeapon;
      activeWeapon = previousWeapon;
      previousWeapon = tempWeapon;
      fistTop = playerTop;
      playerTop = bowTop;
      bowTop = fistTop;
    }*/
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

public void mouseMoved() {
  if (gameState == 2) {
    if(newGame.getHighlight() || continueGame.getHighlight() || quitGame.getHighlight() || saveGame.getHighlight()) {
      cursor(HAND);
    }
    else {
      cursor(ARROW); 
    }
  }
}

public void mousePressed()
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

public void mouseReleased()
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

public void zoneKeyAdd()
{
}

//DEAD CHECK
public boolean checkDead(Character testChar)
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

public void resetValues(){
  cutSceneHalfWay = false;
}

//CORE GAME LOOP
//DRAW FUNCTION
public void draw()
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
//Button class

class Button
{
  private float xPos;
  private float yPos;
  private float bWidth;
  private float bHeight;
  private String text;
  private boolean active;
  private boolean highlight;
  private boolean soundPlayed;
  
  Button(float x, float y, float w, float h, String words, boolean a)
  {
    this.xPos = x;
    this.yPos = y;
    this.bWidth = w;
    this.bHeight = h;
    this.text = words;
    this.active = a;
    this.highlight = false;
    this.soundPlayed = false;
  }
  
  //Display button
  public void display()
  {
    if (this.highlight) {
      if (this.soundPlayed == false) {
         buttonHover.play();
         soundPlayed = true;
      }
    }
    else {
       soundPlayed = false; 
    }
    
    //Box
    if(this.active)
    {
      if( (mouseX <= xPos+(bWidth/2)) && (mouseX >= xPos-(bWidth/2)) &&
        (mouseY <= yPos+(bHeight/2)) && (mouseY >= yPos-(bHeight/2)))
      {
        fill(206,151,59);
        this.highlight = true;
      }
      else
      {
        fill(164,13,13);
        this.highlight = false;
        noStroke();
      }

    }
    else
    {
      fill(150);
      stroke(50);
    }
    strokeWeight(4);
    rect(this.xPos,this.yPos,this.bWidth,this.bHeight);
    
    //Text
    if(this.active)
      if( (mouseX <= xPos+(bWidth/2)) && (mouseX >= xPos-(bWidth/2)) &&
        (mouseY <= yPos+(bHeight/2)) && (mouseY >= yPos-(bHeight/2)))
      {
        fill(164,13,13);
      }
    else
      fill(206,151,59);
      rectMode(CENTER);
      textSize(36);
      textAlign(CENTER,CENTER);
      text(text,this.xPos, this.yPos);
  }
  
  //GETTERS
  public float getXPos(){
    return this.xPos;}
  public float getYPos(){
    return this.yPos;}
  public float getWidth(){
    return this.bWidth;}
  public float getHeight(){
    return this.bHeight;}
  public boolean getHighlight(){
    return this.highlight;}
}
//Chapter class

class Chapter
{
  private String id = "null";
  ArrayList<CutScene> cutScenes = new ArrayList<CutScene>();
  ArrayList<Zone> zones = new ArrayList<Zone>();
  
  
  //Constructor
  Chapter(String id)
  {
  	this.id = id;
  }

  //Getters
  public String getId(){
  	return this.id;}
  public ArrayList<CutScene> getCutScenes(){
  	return this.cutScenes;}
  public ArrayList<Zone> getZones(){
    return this.zones;}

  //Setters
  public void setId(String id){
  	this.id = id;}
  public void setCutScenes(ArrayList<CutScene> cutScenes){
  	this.cutScenes = cutScenes;}
  public void addCutScene(CutScene cutscene){
  	this.cutScenes.add(cutscene);}
  public void setZones(ArrayList<Zone> zones){
    this.zones = zones;}
  public void addZone(Zone newZone){
    this.zones.add(newZone);}

  //Print
  public void print(boolean printCutScenes){
  	println("Chapter: " + this.id);
  	if(printCutScenes == true)
  	{
  		println("CutScenes:");
	  	for(int i = 0; i < this.cutScenes.size(); i++){
	  		this.cutScenes.get(i).printCutScene();
	  	}
  	}
  }
}
//Character Class

class Character
{
  private float xPos;
  private float yPos;
  private float direction;
  private float maxHealth;
  private float currentHealth;
  private float sizeW;
  private float sizeH;
  private Hitbox hBox;
  
  Character()
  {
    this.xPos = 0;
    this.yPos = 0;
    this.direction = 0;
    this.maxHealth = 100;
    this.currentHealth = 100;
    this.hBox = new Hitbox(0, 0, 10, 10, 0, "default");
  }
  
  //Character constructor
  Character(float x, float y, float dir, int h, float wi, float hi, String type)
  {
    this.xPos = x;
    this.yPos = y;
    this.direction = dir;
    this.maxHealth = h;
    this.currentHealth = h;
    this.hBox = new Hitbox(x, y, wi, hi, dir, type);
  }
  
  //Generic display for characters
  //Overwritten by player and enemies
  public void display()
  {
    pushMatrix();
    translate(this.xPos, this.yPos);
    rotate(this.direction);
    stroke(0);
    strokeWeight(1);
    fill(100);
    rectMode(CENTER);
    rect(0, 0, this.sizeW, this.sizeH);
    popMatrix();
    if(hitBoxMode)
      this.hBox.displayBox();
  }
  
  //Reduce Health
  public void reduceHealth(int damage)
  {
    this.currentHealth -= damage;
  }
  
  //Add Health
  public void addHealth(int healing)
  {
    this.currentHealth += healing;
    if(this.currentHealth > this.maxHealth)
      this.currentHealth = this.maxHealth;
  }
  
  //GETTERS AND SETTERS
  public float getXPos(){
    return this.xPos;}
  public float getYPos(){
    return this.yPos;}
  public float getDir(){
    return this.direction;}
  public float getWidth(){
    return this.sizeW;}
  public float getHeight(){
    return this.sizeH;}
  public float getMaxHealth(){
    return this.maxHealth;}
  public float getCurrentHealth(){
    return this.currentHealth;}
  public Hitbox getHitbox(){
    return this.hBox;}
    
  public void setDir(float dir){
    this.direction = dir;}
}
//Checkpoint system

//save or write to file
//somesort of saving icon show up
//COLLISION DETECTION
//X-AXIS
public PVector collision(Hitbox hBox1, Hitbox hBox2, float xChange,float yChange, float collide, float hBox2Angle)
{
  PVector change = new PVector(xChange, yChange, collide);
  
  //NOT ROTATED
  if(hBox2Angle == 0)
  {
    //X-COLLISION
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
        change.x = 0;
        change.z = 1;
      }
  
    //Y-COLLISION
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
        change.y = 0;
        change.z = 1;
      }
  }
  else
  {
    float diagonal = sqrt(pow(hBox1.getWidth()/2,2)+pow(hBox1.getHeight()/2,2));
    //X-CORNER-COLLISION
    if(hBox2.getYPos() == hBox1.getYPos() &&
      hBox1.getXPos() + hBox1.getWidth()/2 >= hBox2.getXPos() - hBox2.getWidth()/2 + xChange &&
      hBox1.getXPos() - hBox1.getWidth()/2 <= hBox2.getXPos() + hBox2.getWidth()/2 + xChange)
      {
        change.x = 0;
        change.z = 1;
      }
    //Y-CORNER-COLLISION
    if(hBox2.getXPos() == hBox1.getXPos() &&
      hBox1.getYPos() + hBox1.getHeight()/2 >= hBox2.getYPos() - hBox2.getHeight()/2 + yChange &&
      hBox1.getYPos() - hBox1.getHeight()/2 <= hBox2.getYPos() + hBox2.getHeight()/2 + yChange)
      {
        change.y = 0;
        change.z = 1;
      }
    //NE-COLLISION
    if(abs((hBox2.getXPos() - hBox2.getWidth()/2 + xChange) - hBox1.getXPos()) +
      abs((hBox2.getYPos() + hBox2.getHeight()/2 + yChange) - hBox1.getYPos()) < diagonal)
      {
        change.x = change.x+0.5f*speed;
        change.y = change.y-0.5f*speed;
        change.z = 1;
      }
    //NW-COLLISION
    if(abs((hBox2.getXPos() + hBox2.getWidth()/2 + xChange) - hBox1.getXPos()) +
      abs((hBox2.getYPos() + hBox2.getHeight()/2 + yChange) - hBox1.getYPos()) < diagonal)
      {
        change.x = change.x-0.5f*speed;
        change.y = change.y-0.5f*speed;
        change.z = 1;
      }
    //SW-COLLISION
    if(abs((hBox2.getXPos() + hBox2.getWidth()/2 + xChange) - hBox1.getXPos()) +
      abs((hBox2.getYPos() - hBox2.getHeight()/2 + yChange) - hBox1.getYPos()) < diagonal)
      {
        change.x = change.x-0.5f*speed;
        change.y = change.y+0.5f*speed;
        change.z = 1;
      }
    //SE-COLLISION
    if(abs((hBox2.getXPos() - hBox2.getWidth()/2 + xChange) - hBox1.getXPos()) +
      abs((hBox2.getYPos() - hBox2.getHeight()/2 + yChange) - hBox1.getYPos()) < diagonal)
      {
        change.x = change.x+0.5f*speed;
        change.y = change.y+0.5f*speed;
        change.z = 1;
      }
  }
  return change;
}
//Configure Chapter
ArrayList<Chapter> chapters = new ArrayList<Chapter>();
Chapter chapter1 = new Chapter("1");
Chapter chapter2 = new Chapter("2");

public void configureChapter(Chapter chapter) {

  //loadreader for scene configure
  BufferedReader reader = createReader("Ch" + chapter.getId() + "/" + "sceneConfigure.txt");

  try
  {
    String line1 = reader.readLine().substring(13);
    int numOfCutScenes = Integer.parseInt(line1);




    for (int i = 0; i < numOfCutScenes; i++) { //For each cutscene
      //skip comment
      reader.readLine();
      String sceneNum = Integer.toString(i+1);
      String nextZone = reader.readLine().substring(9);
      float nextXPos = Float.parseFloat(reader.readLine().substring(12));
      float nextYPos = Float.parseFloat(reader.readLine().substring(12));
      int subScenes = Integer.parseInt(reader.readLine().substring(13));
      CutScene cutscene = new CutScene( sceneNum, subScenes, nextZone);
      cutscene.setNextXPos(nextXPos);
      cutscene.setNextYPos(nextYPos);
      chapter.addCutScene(cutscene);

      //skip comment
      reader.readLine();

      //layers
      for (int j = 0; j < subScenes; j++) {
        String line = reader.readLine().substring(0);
        int layer = Integer.parseInt(line);
        chapter.cutScenes.get(i).addLayer(layer);
      }

      //skip comment
      reader.readLine();

      //sounds
      for (int j = 0; j < subScenes; j++) {
        int sound = Integer.parseInt(reader.readLine().substring(0));
        chapter.cutScenes.get(i).addSound(sound);
      }

      //skip comment
      reader.readLine();

      //duration
      for (int k = 0; k < subScenes; k++) {
        float duration = Float.parseFloat(reader.readLine().substring(0));
        chapter.cutScenes.get(i).addDuration(duration);
      }
    }

    //skip line
    reader.readLine();
  }
  catch(IOException e)
  {
    println("Failed to load scenes");
    e.printStackTrace();
  }
  
  //loadreader for zoneConfigure
  reader = createReader("Ch" + chapter.getId() + "/" + "zoneConfigure.txt");

  try
  {
    String line1 = reader.readLine().substring(9); //#ofzones
    int numOfZones = Integer.parseInt(line1);

    for (int i = 0; i < numOfZones; i++) { //For each zone
      String zoneNum = Integer.toString(i+1);
      Zone newZone = new Zone(zoneNum);
      
      //skip comment
      reader.readLine();
      int numOfTransitions = Integer.parseInt(reader.readLine().substring(15));
      

      //transitions
      for (int j = 0; j < numOfTransitions; j++) {
        //skip comment transition #
        reader.readLine();
        String line = reader.readLine().substring(2);
        int x = Integer.parseInt(line);
        line = reader.readLine().substring(2);
        int y = Integer.parseInt(line);
        line = reader.readLine().substring(2);
        int w = Integer.parseInt(line);
        line = reader.readLine().substring(2);
        int h = Integer.parseInt(line);
        line = reader.readLine().substring(2);
        float r;
        if(line.equals("pi4")){
          r = PI/4.0f;
        }
        else{
          r = Float.parseFloat(line);
        }
        line = reader.readLine().substring(9);//nextzone
        String transitionToZone = line;
        line = reader.readLine().substring(12);//nextPlayerX
        float nextPlayerXPosition = Integer.parseInt(line);
        line = reader.readLine().substring(12);//nextPlayerY
        float nextPlayerYPosition = Integer.parseInt(line);
        Hitbox newTransition = new Hitbox(x,y,w,h,r, "zone_transition");
        newTransition.setZone(transitionToZone);
        newTransition.setNextXPos(nextPlayerXPosition);
        newTransition.setNextYPos(nextPlayerYPosition);
        newZone.addTransitionZone(newTransition);
      }
      //walls

      //skip comment walls
      reader.readLine();
      
      int numOfWalls = Integer.parseInt(reader.readLine().substring(9));
      
      for (int j = 0; j < numOfWalls; j++) {
        //skip comment walls
        reader.readLine();
        int x =  Integer.parseInt(reader.readLine().substring(2));
        int y =  Integer.parseInt(reader.readLine().substring(2));
        int w =  Integer.parseInt(reader.readLine().substring(2));
        int h =  Integer.parseInt(reader.readLine().substring(2));
        String line = reader.readLine().substring(2);
        float r;
        if(line.equals("pi4")){
          r = PI/4.0f;
        }
        else{
          r = Float.parseFloat(line);
        }
        Wall newWall = new Wall( x, y, w, h, r);
        newZone.addWall(newWall);
      }
      
      //Pickups
      
      //skip comment pickups
      reader.readLine();
      
      int numOfPickups = Integer.parseInt(reader.readLine().substring(11));
      
      for(int j = 0; j < numOfPickups; j++){
        //skip comment pickup
        reader.readLine();
        int x =  Integer.parseInt(reader.readLine().substring(2));
        int y =  Integer.parseInt(reader.readLine().substring(2));
        int w =  Integer.parseInt(reader.readLine().substring(2));
        int h =  Integer.parseInt(reader.readLine().substring(2));
        String line = reader.readLine().substring(3);
        
        Key newKey = new Key(x, y, w, h, line);
        newZone.addPickup(newKey);
      }
      
      //Enemies
      
      //skip comment enemies
      reader.readLine();
      
      int numOfEnemies = Integer.parseInt(reader.readLine().substring(11));
      for(int j = 0; j < numOfEnemies; j++){
        //skip comment enemy
        reader.readLine();
        int x =  Integer.parseInt(reader.readLine().substring(2));
        int y =  Integer.parseInt(reader.readLine().substring(2));
        int p =  Integer.parseInt(reader.readLine().substring(2));
        
        Enemy newEnemy = new Enemy(x, y, 0, 100, peopleSize/2, peopleSize/2, PI/2, 100, p);
        newZone.addEnemy(newEnemy);
      }
      chapter.addZone(newZone);
    }
    
    //int size = chapter.getZones().size();
    //for(int i = 0; i < size; i++){
    //  chapter.getZones().get(i).print();
    //}
    
  }
  catch(IOException e)
  {
    println("Failed to load zones");
    e.printStackTrace();
  }
  chapters.add(chapter);
}
//CutScene class

class CutScene
{
  private String id = "null";
  ArrayList <Integer> layers = new ArrayList<Integer>(); //number of layers per subscene
  private int subScenes = 0;
  ArrayList <Integer> sounds = new ArrayList<Integer>(); //number of sounds per subscene
  ArrayList <Float> durations = new ArrayList<Float>();
  private String nextZone = "null";
  private float nextXPos; // Player's x position after a transition
  private float nextYPos; // Player's y position after a transition

  //Constructor
  CutScene(String id, int subScenes, String nextZone)
  {
    this.id = id;
    this.subScenes = subScenes;
    this.nextZone = nextZone;
    this.nextXPos = 0;
    this.nextYPos = 0;
  }

  //Getters
  public String getId(){
    return this.id;}
  public ArrayList <Integer> getLayers(){
    return this.layers;}
  public int getSubScenes(){
    return this.subScenes;}
  public ArrayList <Integer> getSounds(){
    return this.sounds;}
  public ArrayList <Float> getDurations(){
    return this.durations;}
  public String getNextZone(){
    return this.nextZone;}
  public float getNextXPos(){
    return this.nextXPos;}
  public float getNextYPos(){
    return this.nextYPos;}

  //Setters
  public void setId(String id){
    this.id = id;}
  public void setLayers(ArrayList <Integer> layers){
    this.layers = layers;}
  public void setSubScenes(int subScenes){
    this.subScenes = subScenes;}
  public void setSounds(ArrayList <Integer> sounds){
    this.sounds = sounds;}
  public void setDurations(ArrayList <Float> durations){
    this.durations = durations;}
  public void setNextZone(String nextZone){
    this.nextZone = nextZone;}
  public void addLayer(int layer){
  	this.layers.add(layer);}
  public void addSound(int sound){
  	this.sounds.add(sound);}
  public void addDuration(float duration){
  	this.durations.add(duration);}
  public void setNextXPos(float xpos){
    this.nextXPos = xpos;}
  public void setNextYPos(float ypos){
    this.nextYPos = ypos;}

  //Print all info
  public void printCutScene()
  {
    //CutScene Name
    println("Cutscene id: " + this.id);
    println("Next Zone: " + this.nextZone);
    println("Player's next position: " + this.nextXPos + ", " + this.nextYPos);
    println("SubScenes: " + this.subScenes);
    println("Layers:");
    for(int i = 0; i < this.subScenes; i++){
      println(this.layers.get(i));
    }
    println("Sounds:");
    for(int i = 0; i < this.sounds.size(); i++){
      println(this.sounds.get(i));
    }
    println("Durations:");
    for(int i = 0; i < this.durations.size(); i++){
      println(durations.get(i));
    }
  }

}
//Cutscene method
PImage layer1;
int subSceneIndex = 0;
PImage layer2;
boolean layer2Exists = false;
PImage layer3;
boolean layer3Exists = false;

//Sound (Maybe put in seperate place)
SoundFile soundFile1;
SoundFile soundFile2;
SoundFile soundFile3;
boolean soundPlayed1 = false;
boolean soundPlayed2 = false;
boolean soundPlayed3 = false;

float pastTime;
boolean timeUpdated = false;
boolean cutSceneTransitionPlayed = false;
boolean cutSceneHalfWay = false; //half the fade occured

public void playCutScene(int ch, CutScene cutscene){

  if(cutSceneHalfWay){
    if(subSceneIndex < cutscene.getSubScenes()){
      //Display Cutscene image
      for(int i = 0; i < cutscene.getLayers().get(subSceneIndex); i++){
        int layerNum = i+1;
        int subSceneIndexNum = subSceneIndex + 1;
        String source = "Ch" + ch + "/" + ch + "-" + cutscene.getId() + "/" + ch + "-" + cutscene.getId() + "-" + subSceneIndexNum;
        if( cutscene.getLayers().get(subSceneIndex) > 1){
          source = source + "-" + layerNum;
        }
        source = source + ".png";
        //println(source);
        layer1 = loadImage(source);
        
        //println("painting layer: " + layerNum); 
        image(layer1, 0, 0, width, height);
      }
      //TODO:do we need to keep repainting them on the screen if they are static?
      //TODO:Images might not be able to be overwritten
      
      //Play noise if included
      for(int i = 0; i < cutscene.getSounds().get(subSceneIndex); i++){
        int soundNum = i+1;
        //println("Sound num:" + soundNum);
        int subSceneIndexNum = subSceneIndex + 1;
        String source = "Ch" + ch + "/" + ch + "-" + cutscene.getId() + "/" + ch + "-" + cutscene.getId() + "-" + subSceneIndexNum;
        if( cutscene.getSounds().get(subSceneIndex) > 1){
          source = source + "-" + soundNum;
        }
        source = source + ".wav";
        //println("soundPlayed is " + soundPlayed);
        //println(source);
        
        if(soundPlayed1 == false){
          //println("subscene " + subSceneIndex);
          //println("Playing Sound1");
          soundFile1 = new SoundFile(this, source);
          soundFile1.play();
          //println("Turning to true3");
          soundPlayed1 = true;
        }
        if(soundPlayed2 == false && i == 1){
          //println("subscene " + subSceneIndex);
          //println("Playing Sound2");
          soundFile2 = new SoundFile(this, source);
          soundFile2.play();
          soundPlayed2 = true;
        }
        if(soundPlayed3 == false && i == 2){
          //println("subscene " + subSceneIndex);
          //println("Playing Sound3");
          soundFile3 = new SoundFile(this, source);
          soundFile3.play();
          soundPlayed3 = true;
        }
      }
      //TODO: sound might not be able to be overwritten
  
      if(timeUpdated == false){
        pastTime = millis();
        timeUpdated = true;
      }
      //println("pastTime :" + pastTime);
      //println("currentTime :" + millis());
      //Check time for image
      if(millis() - pastTime > cutscene.getDurations().get(subSceneIndex)){
        nextSubScene();
      }
  
    }
    else{
      gameState = 0;
      subSceneIndex = 0;
      timeUpdated = false;
      if(soundPlayed){
        //soundFile.stop();
      }
      //println("Turning to false4");
      soundPlayed1 = false;
      soundPlayed2 = false;
      soundPlayed3 = false;
      cutSceneTransitionPlayed = false;
      save();
      loadZone();
      zoneTransition = true;
      //println("t4");
      resetValues();

      int nextScene = Integer.parseInt(last_cutscene);
      nextScene++;
      last_cutscene = Integer.toString(nextScene);
      
      println("last_cutscene increased by 1");
      
      //println("reset in playCutScene last else");
    }
    
    noCursor();
  }
    cutSceneTransition();
}

public void nextSubScene(){
      subSceneIndex++;
      timeUpdated = false;
      if(soundPlayed){
        //soundFile.stop();
      }
      soundPlayed1 = false;
      soundPlayed2 = false;
      soundPlayed3 = false;
      
      //println("Next SubScene");
      
}


public void cutSceneTransition(){
  pushMatrix();
  if(cutSceneTransitionPlayed == false){
      if(transparency < 255){ //Fade to white
          transparency += transparencyIncrement;
          rectMode(CORNER);
          fill(fillColor, fillColor, fillColor, transparency);
          rect(0, 0, width, height);
          
       }
       else if(transparency == 255){ //Fade from white to new zone
          cutSceneHalfWay = true;

          transparency2 -= transparencyIncrement;
          rectMode(CORNER);
          fill(fillColor, fillColor, fillColor, transparency2);
          rect(0, 0, width, height);
          if(transparency2 == 0){ // To force the next else statement after fade is done
            transparency = 256;
          }
       }
       else{ //reset variables
          zoneTransition = false;
          //println("f5");
          zoneTransition2 = false;
          transparency = 0;
          transparency2 = 255;
          cutSceneTransitionPlayed = true;
       }
  }
  popMatrix();
}
//Enemy class extends Character class

class Enemy extends Character
{
  private float xPos;
  private float yPos;
  private float initX;
  private float initY;
  private int direction;
  private int mDirection;
  private float maxHealth;
  private float currentHealth;
  private float sizeW;
  private float sizeH;
  private Hitbox hBox;
  private float viewAngle; //make sure to put in radians
  private float viewDist;
  private int runTime;
  private int runTimeTracker;
  private boolean shooting;
  private boolean alerted;
  private boolean dead;
  private float patrolSize;
  
  Enemy(float x, float y, int d, float he, float w, float h, float a, float dist, float p)
  {
    this.xPos = x;
    this.yPos = y;
    this.initX = x;
    this.initY = y;
    this.direction = d;       //Int: 0:E, 1:N, 2:W, 3:S
    this.mDirection = -1;           //Int: 0:E, 1:N, 2:W, 3:S, -1:NOT MOVING
    this.maxHealth = he;
    this.currentHealth = he;
    this.sizeW = w;
    this.sizeH = h;
    this.hBox = new Hitbox(x,y,w,h,0,"enemy");
    this.viewAngle = a;
    this.viewDist = dist;
    this.runTime = 0;
    this.runTimeTracker = 0;
    this.shooting = false;
    this.patrolSize = p;
    this.alerted = false;
    this.dead = false;
  }
  
  public void displayBottom()
  {
    pushMatrix();
    translate((width*(this.xPos-cameraX)/512), height*(this.yPos-cameraY)/288);
    imageMode(CENTER);
    if(this.dead)
    {
      if(this.runTimeTracker < 500)
      {
        int temp = runTime;
        this.runTime = millis();
        this.runTimeTracker += this.runTime - temp;
        image(russianBottom.get(384,0,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
      }
      else
        image(russianBottom.get(384,64,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
    }
    else
    {
      if(direction == 0) //RIGHT
      {
        if(mDirection == 0 && !shooting)
        {
          int temp = runTime;
          this.runTime = millis();
          this.runTimeTracker += this.runTime - temp;
          if(this.runTimeTracker >= 400)
            this.runTimeTracker = 0;
          int temp2 = (this.runTimeTracker / 100)+1;
          //println(temp2);
          image(russianBottom.get(64*temp2,0,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
        }
        else
          image(russianBottom.get(0,0,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
      }
      else if(direction == 1) //UP
      {
        if(mDirection == 1 && !shooting)
        {
          int temp = this.runTime;
          this.runTime = millis();
          this.runTimeTracker += this.runTime - temp;
          if(this.runTimeTracker >= 400)
            this.runTimeTracker = 0;
          int temp2 = (this.runTimeTracker / 100)+1;
          //println(temp2);
          image(russianBottom.get(64*temp2,64,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
        }
        else
          image(russianBottom.get(0,64,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
      }
      else if(direction == 2) //LEFT
      {
        if(mDirection == 2 && !shooting)
        {
          int temp = this.runTime;
          this.runTime = millis();
          this.runTimeTracker += this.runTime - temp;
          if(this.runTimeTracker >= 400)
            this.runTimeTracker = 0;
          int temp2 = (this.runTimeTracker / 100)+1;
          //println(temp2);
          image(russianBottom.get(64*temp2,128,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
        }
        else
          image(russianBottom.get(0,128,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
      }
      else if(direction == 3) // DOWN
      {
        if(mDirection == 3 && !shooting)
        {
          int temp = this.runTime;
          this.runTime = millis();
          this.runTimeTracker += this.runTime - temp;
          if(this.runTimeTracker >= 400)
            this.runTimeTracker = 0;
          int temp2 = (this.runTimeTracker / 100)+1;
          //println(temp2);
          image(russianBottom.get(64*temp2,192,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
        }
        else
          image(russianBottom.get(0,192,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
      }
    }
    popMatrix();
  }
  
  public void displayTop()
  {
    pushMatrix();
    translate((width*(this.xPos-cameraX)/512), height*(this.yPos-cameraY)/288);
    imageMode(CENTER);
    if(this.dead)
    {
      if(this.runTimeTracker < 500)
      {
        int temp = runTime;
        this.runTime = millis();
        this.runTimeTracker += this.runTime - temp;
        image(russianTop.get(384,0,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
      }
    }
    else
    {
      if(direction == 0) //RIGHT
      {
        if(mDirection == 0 && !shooting)
        {
          int temp = this.runTime;
          this.runTime = millis();
          this.runTimeTracker += this.runTime - temp;
          if(this.runTimeTracker >= 400)
            this.runTimeTracker = 0;
          int temp2 = (this.runTimeTracker / 100)+1;
          //println(temp2);
          image(russianTop.get(64*temp2,0,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
        }
        else if(shooting)
        {
          pushMatrix();
          translate(0, -48);
          rotate(atan2(player.getYPos() - this.yPos, player.getXPos() - this.xPos));
          image(russianTop.get(320, 0, 64, 64), 0, 16, peopleSize*scaler, peopleSize*scaler);
          popMatrix();
        }
        else
          image(russianTop.get(0,0,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
      }
      else if(direction == 1) //UP
      {
        if(mDirection == 1 && !shooting)
        {
          int temp = this.runTime;
          this.runTime = millis();
          this.runTimeTracker += this.runTime - temp;
          if(this.runTimeTracker >= 400)
            this.runTimeTracker = 0;
          int temp2 = (this.runTimeTracker / 100)+1;
          //println(temp2);
          image(russianTop.get(64*temp2,64,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
        }
        else if(shooting)
        {
          //image(russianTop.get(320, 64, 64, 64), 0, -32, peopleSize*scaler, peopleSize*scaler);
          pushMatrix();
          translate(0, -48);
          rotate(atan2(player.getYPos() - this.yPos, player.getXPos() - this.xPos) + PI/2);
          image(russianTop.get(320, 64, 64, 64), 0, 16, peopleSize*scaler, peopleSize*scaler);
          popMatrix();
        }
        else
          image(russianTop.get(0,64,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
      }
      else if(direction == 2) //LEFT
      {
        if(mDirection == 2 && !shooting)
        {
          int temp = this.runTime;
          this.runTime = millis();
          this.runTimeTracker += this.runTime - temp;
          if(this.runTimeTracker >= 400)
            this.runTimeTracker = 0;
          int temp2 = (this.runTimeTracker / 100)+1;
          //println(temp2);
          image(russianTop.get(64*temp2,128,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
        }
        else if(shooting)
        {
          //image(russianTop.get(320, 128, 64, 64), 0, -32, peopleSize*scaler, peopleSize*scaler);
          pushMatrix();
          translate(0, -48);
          rotate(atan2(player.getYPos() - this.yPos, player.getXPos() - this.xPos) + PI);
          image(russianTop.get(320, 128, 64, 64), 0, 16, peopleSize*scaler, peopleSize*scaler);
          popMatrix();
        }
        else
          image(russianTop.get(0,128,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
      }
      else if(direction == 3) // DOWN
      {
        if(mDirection == 3 && !shooting)
        {
          int temp = this.runTime;
          this.runTime = millis();
          this.runTimeTracker += this.runTime - temp;
          if(this.runTimeTracker >= 400)
            this.runTimeTracker = 0;
          int temp2 = (this.runTimeTracker / 100)+1;
          //println(temp2);
          image(russianTop.get(64*temp2,192,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
        }
        else if(shooting)
        {
          //image(russianTop.get(320, 192, 64, 64), 0, -32, peopleSize*scaler, peopleSize*scaler);
          pushMatrix();
          translate(0, -48);
          rotate(atan2(player.getYPos() - this.yPos, player.getXPos() - this.xPos) - PI/2);
          image(russianTop.get(320, 192, 64, 64), 0, 16, peopleSize*scaler, peopleSize*scaler);
          popMatrix();
        }
        else
          image(russianTop.get(0,192,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
      }
    }
    if(hitBoxMode)
    {
      pushMatrix();
      this.hBox.displayBox();
      fill(0,150);
      rotate(-PI/2*direction);
      arc(0,0,this.viewDist*scaler*2,this.viewDist*scaler*2,-PI/4,PI/4);
      popMatrix();
    }
    popMatrix();
  }

  //Enemies walk around in a square unless they detect an enemy
  public void behaviorCheck()
  {
    float xChange = 0;
    float yChange = 0;
    if(!alerted)
    {
      //Moving in square
      if(mDirection == 0)                          //Moving Right
      {
        if(this.xPos < this.initX)
          xChange = 1;
        else
          mDirection = -1;
      }
      else if(mDirection == 1)                          //Moving Up
      {
        if(abs(this.yPos-this.initY) < this.patrolSize)
          yChange = -1;
        else
          mDirection = -1;
      }
      else if(mDirection == 2)                          //Moving Left
      {
        if(abs(this.xPos-this.initX) < this.patrolSize)
          xChange = -1;
        else
          mDirection = -1;
      }
      else if(mDirection == 3)                          //Moving Down
      {
        if(this.yPos < this.initY)
          yChange = 1;
        else
          mDirection = -1;
      }
      //Stopping at square corner for 3 seconds
      else if(mDirection == -1)
      {
        int temp = this.runTime;
        this.runTime = millis();
        this.runTimeTracker += this.runTime - temp;
        if(this.runTimeTracker >= 3000)
        {
          direction = (direction+1)%4;
          mDirection = direction;
          this.runTimeTracker = 0;
        }
      }
    }
    else
    {
      float distance = sqrt(pow(this.xPos-player.getXPos(),2)+pow(this.yPos-player.getYPos(),2));
      float angle = acos(abs(this.xPos-player.getXPos())/distance);
      
      if(angle <= PI/4 && player.getXPos() >= this.xPos)
      {
        direction = 0;
        mDirection = 0;
        xChange = 1.5f;
      }
      else if(angle >= PI/4 && player.getYPos() <= this.yPos)
      {
        direction = 1;
        mDirection = 1;
        yChange = -1.5f;
      }
      else if(angle <= PI/4 && player.getXPos() <= this.xPos)
      {
        direction = 2;
        mDirection = 2;
        xChange = -1.5f;
      }
      else if(angle >= PI/4 && player.getYPos() >= this.yPos)
      {
        direction = 3;
        mDirection = 3;
        yChange = 1.5f;
      }
    }
    if(!shooting)
      movement(xChange,yChange);
    visionCheck();
  }
  
  public void movement(float xChange, float yChange)
  {
    PVector change = new PVector(xChange,yChange,0);
    
    //Wall collision and correction
    for(int i = 0; i < walls.size(); i++)
    {
      change = collision(walls.get(i).getHitbox(), this.hBox, change.x, change.y, change.z, walls.get(i).getDirection());
      xChange = change.x;
      yChange = change.y;
    }
    
    //Fellow enemy collision and correction
    for(int i = 0; i < enemies.size(); i++)
    {
      if(enemies.get(i) != this)
      {
        change = collision(enemies.get(i).getHitbox(), this.hBox, change.x, change.y, change.z, 0);
        xChange = change.x;
        yChange = change.y;
      }
    }
    //Player collision
    change = collision(player.getHitbox(), this.hBox, change.x, change.y, change.z, 0);
    xChange = change.x;
    yChange = change.y;
    
    //Map boundary collision and correction
    if(this.xPos + xChange > 1120 || this.xPos + xChange < 0)
      xChange = 0;
    if(this.yPos + yChange > 544 || this.yPos + yChange < 0)
      yChange = 0;
    this.xPos += xChange;
    this.yPos += yChange;
    
    //Hitbox placement
    this.hBox.setXPos(this.xPos);
    this.hBox.setYPos(this.yPos);
  }

  public void visionCheck()
  {
    float distance = sqrt(pow(this.xPos-player.getXPos(),2)+pow(this.yPos-player.getYPos(),2));
    float angle = acos(abs(this.xPos-player.getXPos())/distance);
    if(alerted)
    {
      if(distance <= this.viewDist*1.5f)
        attack();
      else
        shooting = false;
    }
    else
    {
      if(this.direction == 0 && angle <= PI/4 && distance <= this.viewDist && player.getXPos() >= this.xPos)
      {
        for(int i = 0; i < enemies.size(); i++)
        {
          enemies.get(i).setAlert(true);
          enemies.get(i).setTimer(0);
        }
      }
      else if(this.direction == 1 && angle >= PI/4 && distance <= this.viewDist && player.getYPos() <= this.yPos)
      {
        for(int i = 0; i < enemies.size(); i++)
        {
          enemies.get(i).setAlert(true);
          enemies.get(i).setTimer(0);
        }
      }
      else if(this.direction == 2 && angle <=PI/4 && distance <= this.viewDist && player.getXPos() <= this.xPos)
      {
        for(int i = 0; i < enemies.size(); i++)
        {
          enemies.get(i).setAlert(true);
          enemies.get(i).setTimer(0);
        }
      }
      else if(this.direction == 3 && angle >= PI/4 && distance <= this.viewDist && player.getYPos() >= this.yPos)
      {
        for(int i = 0; i < enemies.size(); i++)
        {
          enemies.get(i).setAlert(true);
          enemies.get(i).setTimer(0);
        }
      }
    }
  }

  public void attack()
  {
    int temp = this.runTime;
    this.runTime = millis();
    this.runTimeTracker += this.runTime - temp;
    if(this.runTimeTracker >= 300)
    {
      ak47.play();
      float angle = atan2(player.getYPos() - this.yPos, player.getXPos() - this.xPos);
      projectiles.add(new Projectile(this.xPos + cos(angle)*bulletSpeed*1.5f, this.yPos + sin(angle)*bulletSpeed*1.5f, bulletDamage, bulletSpeed, cos(angle), sin(angle), bulletSize, bulletSize, "hostile_damage"));
      this.runTimeTracker = 0;
      this.shooting = true;
    }
  }

  //SETTERS
  public void setCurrentHealth(float health){
    this.currentHealth = health;}
  public void setAlert(boolean status){
    this.alerted = status;}
  public void setTimer(int time){
    this.runTimeTracker = time;}
  public void setShooting(boolean shoot){
    this.shooting = shoot;}
  public void setDead(boolean dead){
    this.dead = dead;}

  //GETTERs
  public float getCurrentHealth(){
    return this.currentHealth;}
  public Hitbox getHitbox(){
    return this.hBox;}
  public boolean getAlert(){
    return this.alerted;}
  public boolean getDead(){
    return this.dead;}
  
  public void print(){
    println("Enemy:");
    println("x = " + this.initX);
    println("y = " + this.initY);
    println("width = " + this.sizeW);
    println("height = " + this.sizeH);
  }

}
//Gameplay Method
boolean deathPlayed = false;
float savedTime = millis();
public void gamePlay()
{
 //MUSIC CONTROL
 if(themePlayed){
   themePlayed = false;
   theme.amp(0.4f);
   theme.stop();
 }

  //INTRO
  noCursor();

  //MENUS
  
  if(pause == false)
  {
    //DRAW BACKGROUND ENVIRONMENT
    if(cutSceneHalfWay){
      
      pushMatrix();
      imageMode(CORNER);
      //fill(255);
      noStroke();
      //Draw horizon view
      image(horizonView, 0,-30,width,height);
      //Draw background
      image(background,-cameraX*scaler,-cameraY*scaler,background.width*scaler,background.height*scaler);
      popMatrix();
    }
    

    
    //Player position update
    if(keyPressed && !zoneTransition)
    {
      if(keyCode == UP || key == 'w' || key == 'W'){
        mUp = true;

        if(millis() - savedTime > 300){
          //println(currentChapter);
          if (currentChapter.equals("2")) { 
            floor_step.play();
          }
          else {
            step.play();
          }
          //speed = 4.0 * (player.getCurrentStamina()/player.getMaxStamina());
          savedTime = millis();
        }
      }
      if(keyCode == DOWN || key == 's' || key == 'S'){
        mDown = true;
        
        if(millis() - savedTime > 300){
          if (currentChapter.equals("2")) { 
            floor_step.play();
          }
          else {
            step.play();
          }
          //speed = 4.0 * (player.getCurrentStamina()/player.getMaxStamina());
          savedTime = millis();
        }
      }
      if(keyCode == LEFT || key == 'a' || key == 'A'){
        mLeft = true;

        if(millis() - savedTime > 300){
          if (currentChapter.equals("2")) { 
            floor_step.play();
          }
          else {
            step.play();
          }
          //speed = 4.0 * (player.getCurrentStamina()/player.getMaxStamina());
          savedTime = millis();
        }
      }
      if(keyCode == RIGHT || key == 'd' || key == 'D'){
        mRight = true;

        if(millis() - savedTime > 300){
          if (currentChapter.equals("2")) { 
            floor_step.play();
          }
          else {
            step.play();
          }
          //speed = 4.0 * (player.getCurrentStamina()/player.getMaxStamina());
          savedTime = millis();
        }
      }
    }  
    if(mUp == true){
      player.movement(0, -1*speed);
      if (player.getCurrentStamina() > 0 && !exhausted) {
        player.setStamina(player.getCurrentStamina()-0.2f);
      }
      else if(player.getCurrentStamina() < player.getMaxStamina() &&  exhausted){
        player.setStamina(player.getCurrentStamina()+1);}
      player.setMDir(1);}
      
    if(mDown == true){
      player.movement(0, speed);
      if (player.getCurrentStamina() > 0 && !exhausted) {
        player.setStamina(player.getCurrentStamina()-0.2f);
      }
      else if(player.getCurrentStamina() < player.getMaxStamina() &&  exhausted){
        player.setStamina(player.getCurrentStamina()+1);}
      player.setMDir(3);}
      
    if(mLeft == true){
      player.movement(-1*speed, 0);
      if (player.getCurrentStamina() > 0 && !exhausted) {
        player.setStamina(player.getCurrentStamina()-0.2f);
      }
      else if(player.getCurrentStamina() < player.getMaxStamina() &&  exhausted){
        player.setStamina(player.getCurrentStamina()+1);}
      player.setMDir(2);}
      
    if(mRight == true){
      player.movement(speed, 0);
      if (player.getCurrentStamina() > 0 && !exhausted) {
        player.setStamina(player.getCurrentStamina()-0.2f);
      }
      else if(player.getCurrentStamina() < player.getMaxStamina() &&  exhausted){
        player.setStamina(player.getCurrentStamina()+1);}
        
      player.setMDir(0);}
        
    if (mUp == false && mDown == false && mLeft == false && mRight == false) {
      if (player.getCurrentStamina() < player.getMaxStamina()) {
         player.setStamina(player.getCurrentStamina()+2); 
      }
    }
    if(player.getCurrentStamina() <= 4)
      exhausted = true;
    if(player.getCurrentStamina() == player.getMaxStamina() && exhausted)
      exhausted = false;
      
    player.setDir(mouseAngle());
    for(int i = 0; i < enemies.size(); i++)
    {
      if(enemies.get(i).getDead() == false)
        enemies.get(i).behaviorCheck();
    }
    
    if(cutSceneHalfWay){
      //Player and Enemy display
      for(int i = 0; i < enemies.size(); i++)
        enemies.get(i).displayBottom();
      player.displayBottom();
    }
    
    //Pickup Display
    //println("Pickups size: " + pickups.size());
    for(int i = 0; i < pickups.size(); i++)
      pickups.get(i).display();
    
    //Projectile Display
    if(projectiles.size() > 0)
    {
      for(int i = 0; i < projectiles.size(); i++)
      {
        boolean removed = false;
        PVector change = new PVector(projectiles.get(i).getXVector(),projectiles.get(i).getYVector(),0);
        //WALL COLLISION
        for(int j = 0; j < walls.size(); j++)
        {
          if(removed == false)
          {
            change = collision(walls.get(j).getHitbox(), projectiles.get(i).getHitbox(), change.x, change.y, change.z, walls.get(j).getDirection());
            if(change.z == 1)
            {
              //projectiles.remove(i);
              removed = true;
            }
          }
        }
        
        //Character collision
        if(projectiles.size() > 0)
        {
          if(projectiles.get(i).getType().equals("hostile_damage") && removed == false)
          {
            change = collision(player.getHitbox(),projectiles.get(i).getHitbox(), change.x, change.y, change.z, 0);
            if(change.z == 1)
            {
              player.setHealth(player.getCurrentHealth() - projectiles.get(i).getDamage());
              if (!dead) {
                wounded.play();
              }
              removed = true;
            }
          }
          else if(projectiles.get(i).getType().equals("friendly_damage") && removed == false)
          {
            for(int j = 0; j < enemies.size(); j++)
            {
              change = collision(enemies.get(j).getHitbox(), projectiles.get(i).getHitbox(), change.x, change.y, change.z, 0);
              if(change.z == 1 && enemies.get(j).getDead() == false)
              {
                enemies.get(j).setCurrentHealth(enemies.get(j).getCurrentHealth() - projectiles.get(i).getDamage());
                if(checkDead(enemies.get(j))) {
                  enemies.get(j).setDead(true);
                  death.play();  
                }
                removed = true;
                change.z = 0;
              }
            }
          }
        }
        
        //Out of bounds Check
        if(removed == false)
        {
          if(projectiles.get(i).getXPos() < -50 || projectiles.get(i).getXPos() > 1170 ||
            projectiles.get(i).getYPos() < -50 || projectiles.get(i).getYPos() > 604)
            {
              //projectiles.remove(i);
              removed = true;
            }
        }
        
        if(removed)
        {
          projectiles.remove(i);
          i--;
        }
        else
          projectiles.get(i).display();
      }
    }
    
    
    
    if(cutSceneHalfWay){
      player.displayTop();
      for(int i = 0; i < enemies.size(); i++)
        enemies.get(i).displayTop();
      //Draw foreground
      pushMatrix();
      imageMode(CORNER);
      //fill(255);
      noStroke();
      //Draw foreground
      image(foreground, -cameraX*scaler,-cameraY*scaler,foreground.width*scaler,foreground.height*scaler);
      popMatrix();
    }
    
    if(hitBoxMode){
      //Wall display
      for(int i = 0; i < walls.size(); i++)
        walls.get(i).displayWall();
        
      //Transition Zone display
      for(int i = 0; i < transitions.size(); i++) {
        pushMatrix();
        translate((transitions.get(i).getXPos()-cameraX)*scaler,(transitions.get(i).getYPos()-cameraY)*scaler);
        transitions.get(i).displayBox();
        popMatrix();
      }
    }
    
    player.cameraMove();
    
    //HUD Display
    hud.updateValues(player.getCurrentHealth(), player.getCurrentStamina(), player.getCurrentTemp(), player.getCurrentAmmo());
    if(cutSceneHalfWay && !zoneTransition){
      hud.display();
    }

    
     if(zoneTransition == true){ //For zone transitions

    
    
      if(flashBack == true){
        fillColor = 255;
      }
      else{
        fillColor = 0;
      }
     
     if(transparency < 255){ //Fade to white
        transparency += transparencyIncrement;
        fill(fillColor, fillColor, fillColor, transparency);
        pushMatrix();
        rectMode(CORNER);
        rect(0, 0, width, height);
        popMatrix();
              if(soundPlayed == false){
                 soundFile.play();
                 
                 if(!nextZone.equals("-1")){
                   theme.loop();
                   siberia.play();
                 }
                 //println("Turning to true1");
                 soundPlayed = true;
               }
     }
     else if(transparency == 255){ //Fade from white to new zone
        cutSceneHalfWay = true;
         //add switch statement of the variety of zones to transition to
        loadZone();       
        player.setX(nextPlayerX);
        player.setY(nextPlayerY);
        player.cameraMove();
        pushMatrix();
        imageMode(CORNER);
        //fill(255);
        noStroke();
        //Draw horizon view
        image(horizonView, 0,-30,width,height);
        //Draw background
        image(background,-cameraX*scaler,-cameraY*scaler,background.width*scaler,background.height*scaler);
        popMatrix();
        pushMatrix();
        imageMode(CORNER);
        //fill(255);
        noStroke();
        //Draw foreground
        image(foreground, -cameraX*scaler,-cameraY*scaler,foreground.width*scaler,foreground.height*scaler);
        popMatrix();
        transparency2 -= transparencyIncrement;
        fill(fillColor, fillColor, fillColor, transparency2);
        pushMatrix();
        rectMode(CORNER);
        rect(0, 0, width, height);
        popMatrix();
        if(transparency2 == 0){ // To force the next else statement after fade is done
          transparency = 256;
        }
     }
     else{ //reset variables
        zoneTransition = false;
        //println("f1");
        zoneTransition2 = false;
        transparency = 0;
        transparency2 = 255;
        //println("Turning to false2");
        soundPlayed = false;
        save();

     }
     
     
    }
    
  }
  //Ch4 cutscene interrupt
  if(currentChapter.equals("4") && currentZone.equals("1") && killTrigger == false)
  {
    
    for(int i = 0; i < enemies.size(); i++)
    {
      killTrigger = true;
      if(enemies.get(i).getDead() == false){
        killTrigger = false;
        break;
      }
    }
    if(killTrigger)
    {
      //println("Killtrigger");
      //TODO: make sure this shit works
      nextZone = "-1";
      loadZone();
    }
  }

  if(checkDead(player))
  {
   if (deathPlayed==false) {
     death.play();
     deathPlayed = true;
   }
	deadScreen();
  }
  printSave(saveCompleted); //Prints if recently saved
  //println("nextZone is " + nextZone);
}
//Heads Up Display class

class HUD
{
  private float health;
  private float stamina;
  private float temperature;
  private int ammo;
  
  HUD(float h, float s, float t, int a)
  {
    this.health = h;
    this.stamina = s;
    this.temperature = t;
    this.ammo = a;
  }
  
  public void updateValues(float h, float s, float t, int a)
  {
    this.health = h;
    this.stamina = s;
    this.temperature = t;
    this.ammo = a;
  }
  
  public void display()
  {
    pushMatrix();
    //Crosshair
    if(mouseY >= 78)
      image(crosshairs, mouseX, mouseY - 78);
    else
      image(crosshairs,mouseX, 0);
    
    //Health bar
    rectMode(CORNER);
    imageMode(CORNER);
    noStroke();
    image(hudHealth, width/40-5, (height/20)-5);
    fill(100,100,100,100);
    rect(2*width/40-2, height/20-2, 5*width/20+4, 5*height/200+4);
    fill(255,0,0,255);
    rect(2*width/40, height/20, (health/100.0f)*5*width/20, 5*height/200);
    
    //Stamina bar
    image(hudEnergy, width/40-5, (height/20)-2+32);
    fill(100,100,100,100);
    rect(2*width/40-2, height/20 + -2 + 32, 5*width/20+4, 5*height/200+4);
    if(exhausted)
      fill(255,255,0,255);
    else
      fill(0,255,0,255);
    rect(2*width/40, height/20 + 32 , (stamina/100.0f)*5*width/20, 5*height/200);
    
    
    //ammo counter
    for(int i = 0; i < this.ammo; i++)
    {
      image(hudAmmo, width/40-2 + i*10, (height/20)-2+64);
    }
    
    popMatrix();
  }
}
//Hitbox class

class Hitbox
{
  private float xPos;
  private float yPos;
  private float sizeW;
  private float sizeH;
  private float direction;
  private String type;
  private String zone; // Next zone for zone transition boxes
  private float nextXPos; // Player's x position after a transition
  private float nextYPos; // Player's y position after a transition
  
  Hitbox(float x, float y, float w, float h, float d, String t)
  {
    this.xPos = x;
    this.yPos = y;
    this.sizeW = w;
    this.sizeH = h;
    this.direction = d;
    this.type = t;
    this.zone = "null";
    this.nextXPos = 0;
    this.nextYPos = 0;
  }
  
  //Displays hitbox
  //Color based on object type
  //Green = player
  //Red = enemy
  //Blue = ally
  //Cyan = friendly damage
  //Yellow = hostile damage
  //Light Gray = wall
  //Magenta = other
  public void displayBox()
  {
    pushMatrix();
    if(!type.equals("player"))
      //translate((width*(this.xPos-cameraX)/512), height*(this.yPos-cameraY)/288);
      
    //rotate(this.direction);
    rectMode(CENTER);
    noStroke();
    int c;
    if(type.equals("player"))
      c = color(0,255,0);
    else if(type.equals("enemy"))
      c = color(255,0,0);
    else if(type.equals("ally"))
      c = color(0,0,255);
    else if(type.equals("friendly_damage"))
      c = color(0,255,255);
    else if(type.equals("zone_transition"))
      c = color(0,0,170);
    else if(type.equals("hostile_damage"))
      c = color(255,255,0);
    else if(type.equals("wall"))
      c = color(200,200,200); //silver
    else
      c = color(255,0,255);
    fill(c, 100);
    rotate(this.direction);
    if(type.equals("player"))
      rect(0, 0, this.sizeW*scaler, this.sizeH*scaler);
    else
      rect(0, 0, this.sizeW*scaler, this.sizeH*scaler);
    popMatrix();
    
    pushMatrix();
    textAlign(LEFT,BOTTOM);
    text("( " + this.xPos + " , " + this.yPos + " ) ", 0, 0);
    popMatrix();
  }
  
  
  //GETTERS AND SETTERS
  public float getXPos(){
    return this.xPos;}
  public float getYPos(){
    return this.yPos;}
  public float getDir(){
    return this.direction;}
  public float getWidth(){
    return this.sizeW;}
  public float getHeight(){
    return this.sizeH;}
  public String getType(){
    return this.type;}
  public String getZone(){
    return this.zone;}
  public float getNextXPos(){
    return this.nextXPos;}
  public float getNextYPos(){
    return this.nextYPos;}
  
  public void setXPos(float x){
    this.xPos = x;}
  public void setYPos(float y){
    this.yPos = y;}
  public void setDir(float dir){
    this.direction = dir;}
  public void setZone(String z){
    this.zone = z;}
  public void setNextXPos(float nextXPos){
    this.nextXPos = nextXPos;}
  public void setNextYPos(float nextYPos){
    this.nextYPos = nextYPos;} 
    
    public void print(){
      println("Hitbox:");
      println("X = " + this.xPos);
      println("Y = " + this.yPos);
      println("direction = " + this.direction);
      println("Zone to transition to : " + this.zone);
      println("Next Player X position : " + this.nextXPos);
      println("Next Player Y position : " + this.nextYPos);
    }
  }
//Key class extends Pickup

class Key extends Pickup
{
  private float xPos;
  private float yPos;
  private float sizeW;
  private float sizeH;
  private Hitbox hBox;
  private String identifier;
  private PImage image;
  
  Key(float x, float y, float w, float h, String id)
  {
    this.xPos = x;
    this.yPos = y;
    this.sizeW = w;
    this.sizeH = h;
    this.hBox = new Hitbox(x, y, w, h, 0, "pickup");
    this.identifier = id;
    this.image = loadImage("Pickups/" + this.identifier + ".png");
  }
  
  public void display()
  {
    pushMatrix();
    translate((width*(this.xPos-cameraX)/512), height*(this.yPos-cameraY)/288);
    imageMode(CENTER);
    image(this.image,0,0, this.sizeW, this.sizeH);
    rectMode(CENTER);
    pushMatrix();
    if(hitBoxMode)
      this.hBox.displayBox();
    popMatrix();
    popMatrix();
    
    //Hitbox placement
    this.hBox.setXPos(this.xPos);
    this.hBox.setYPos(this.yPos);
  }
  
  public String getID(){
    return this.identifier;}
  
  public void activate()
  {
    switch(this.identifier){
      case "dynamite": dynamite = 1;
                       Hitbox temp = new Hitbox(745,266,200,100,0,"zone_transition");
                       temp.setZone("-1");
                       temp.setNextXPos(355);
                       temp.setNextYPos(324);
                       transitions.add(temp);
                       
                       break;
      case "rope": dynamite = 1;
                       break;
      case "ammo": player.setCurrentAmmo(player.getCurrentAmmo() + 5);
                   if(player.getCurrentAmmo() > 30)
                     player.setCurrentAmmo(30);
                   break;
      case "health": player.setHealth(player.getCurrentHealth() + 25);
                     if(player.getCurrentHealth() > 100)
                       player.setHealth(100);
                     break;
      case "bow": activeWeapon = bow;
                  player.setCurrentAmmo(10);
                  playerTop = bowTop;
                  previousWeapon = none;
                  break;
      case "kayak":
           Hitbox temp2 = new Hitbox(845,151,90,90,0,"zone_transition");
           temp2.setZone("-1");
           temp2.setNextXPos(355);
           temp2.setNextYPos(324);
           transitions.add(temp2);
           break;
      default: println("INVALID KEY TYPE, DUMMY");
                       break;
    }
  }
  
  public Hitbox getHitbox(){
    return this.hBox;}
  public float getDirection(){
    return 0;}
}
boolean themePlayed = false;

public void mainMenu()
{
  //Display background/ background animation
  menu_background.resize(width,height);
  image(menu_background, 0, 0);
    
  //Display buttons
  newGame.display();
  continueGame.display();
  quitGame.display();
  saveGame.display();
  printSave(saveCompleted); //Prints if recently saved
  if(!themePlayed){
    theme.amp(1.0f);
    theme.loop();
    themePlayed = true;
  }
  
}
//Returns the angle in radians between the player and the current mouse position
public float mouseAngle()
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
//Pickup superclass

class Pickup
{
  private float xPos;
  private float yPos;
  private float sizeW;
  private float sizeH;
  private Hitbox hBox;
  
  Pickup()
  {
    
    this.xPos = 0;
    this.yPos = 0;
    this.sizeW = 32;
    this.sizeH = 32;
    this.hBox = new Hitbox(0, 0, 32, 32, 0, "pickup");
  }
  
  Pickup(float x, float y, float w, float h)
  {
    this.xPos = x;
    this.yPos = y;
    this.sizeW = w;
    this.sizeH = h;
    this.hBox = new Hitbox(x, y, w, h, 0, "pickup");
  }
  public void activate(){
  }
  
  public void display(){
    pushMatrix();
    if(hitBoxMode)
      this.hBox.displayBox();
    popMatrix();
    
    //Hitbox placement
    this.hBox.setXPos(this.xPos);
    this.hBox.setYPos(this.yPos);
  }
  
  public String getID(){
    return "pickup";}
  public Hitbox getHitbox(){
    return this.hBox;}
  public float getDirection(){
    return 0;}
}
//Player subclass

boolean nextZoneChanged = false;

class Player extends Character
{
  private float xPos;
  private float yPos;
  private float direction;        //Aiming direction
  private int mDirection;         //Movement direction
  private float maxHealth;
  private float currentHealth;
  private float maxStamina;
  private float currentStamina;
  private float temperature;
  private int ammo;
  private float sizeW;
  private float sizeH;
  private Hitbox hBox;
  private int runTime;
  private int runTimeTracker;
  private boolean invincible;
  private float invTimer;
  private float invTime;
  
  Player(float x, float y, float dir, float h, float s, float t, int a, float wi, float hi, String type)
  {
    //Default constructor
    this.xPos = x;
    this.yPos = y;
    this.direction = dir;        //Radians: 0-2PI
    this.mDirection = 0;       //Int: 0:E, 1:N, 2:W, 3:S
    this.maxHealth = 100;
    this.currentHealth = h;
    this.maxStamina = 100;
    this.currentStamina = s;
    this.temperature = t;
    this.ammo = a;
    this.sizeW = wi;
    this.sizeH = hi;
    this.hBox = new Hitbox(x, y, wi, hi, 0, type);
    this.runTime = 0;
    this.runTimeTracker = 0;
    this.invincible = false;
    this.invTimer = 0;
    this.invTime = 1000;
  }
  
  //Player display bottom half
  public void displayBottom()
  {
    //Sprites instead of squares
    pushMatrix();
    
    //X-Translation
    if(this.xPos < 256)                                              //Camera against left wall
      translate(width/2 - ((width/2) * ((256-this.xPos)/256)), 0);
    else if(this.xPos > 864)                                         //Camera against right wall
      translate(width/2 + ((width/2) * ((this.xPos-864)/256)),0);
    else
      translate(width/2, 0);
      
    //Y-Translation
    if(this.yPos < 144)
      translate(0, height/2 - ((height/2) * ((144-this.yPos)/144))); //Camera against top wall
    else if(this.yPos > 410)
      translate(0, height/2 + ((height/2) * ((this.yPos-410)/144))); //Camera against bottom wall
    else
      translate(0, height/2);
    
    float modifier = 1.0f;
    if(exhausted)
      modifier = 0.75f;
    
    imageMode(CENTER);
    if(mDirection == 0) //RIGHT
    {
      if(mRight)
      {
        int temp = runTime;
        runTime = millis();
        runTimeTracker += runTime - temp;
        if(runTimeTracker*modifier >= 600)
          runTimeTracker = 0;
        int temp2 = (PApplet.parseInt(runTimeTracker*modifier) / 100)+1;
        //println(temp2);
        image(playerBottom.get(64*temp2,0,64,64), 2, -32, peopleSize*scaler, peopleSize*scaler);
      }
      else
        image(playerBottom.get(0,0,64,64), 2, -32, peopleSize*scaler, peopleSize*scaler);
    }
    else if(mDirection == 1) //UP
    {
      if(mUp)
      {
        int temp = runTime;
        runTime = millis();
        runTimeTracker += runTime - temp;
        if(runTimeTracker*modifier >= 600)
          runTimeTracker = 0;
        int temp2 = (PApplet.parseInt(runTimeTracker*modifier) / 100)+1;
        //println(temp2);
        image(playerBottom.get(64*temp2,64,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
      }
      else
        image(playerBottom.get(0,64,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
    }
    else if(mDirection == 2) //LEFT
    {
      if(mLeft)
      {
        int temp = runTime;
        runTime = millis();
        runTimeTracker += runTime - temp;
        if(runTimeTracker*modifier >= 600)
          runTimeTracker = 0;
        int temp2 = (PApplet.parseInt(runTimeTracker*modifier) / 100)+1;
        //println(temp2);
        image(playerBottom.get(64*temp2,128,64,64), -4, -32, peopleSize*scaler, peopleSize*scaler);
      }
      else
        image(playerBottom.get(0,128,64,64), -4, -32, peopleSize*scaler, peopleSize*scaler);
    }
    else if(mDirection == 3) // DOWN
    {
      if(mDown)
      {
        int temp = runTime;
        runTime = millis();
        runTimeTracker += runTime - temp;
        if(runTimeTracker*modifier >= 600)
          runTimeTracker = 0;
        int temp2 = (PApplet.parseInt(runTimeTracker*modifier) / 100)+1;
        //println(temp2);
        image(playerBottom.get(64*temp2,192,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
      }
      else
        image(playerBottom.get(0,192,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
    }
    if(hitBoxMode) {
      rectMode(CENTER);
      this.hBox.displayBox();
    }
    popMatrix();
  }
   //Player display top half
  public void displayTop()
  {
    //Sprites instead of squares
    pushMatrix();
    
    //X-Translation
    if(this.xPos < 256)                                              //Camera against left wall
      translate(width/2 - ((width/2) * ((256-this.xPos)/256)), 0);
    else if(this.xPos > 864)                                         //Camera against right wall
      translate(width/2 + ((width/2) * ((this.xPos-864)/256)),0);
    else
      translate(width/2, 0);
      
    //Y-Translation
    if(this.yPos < 144)
      translate(0, height/2 - ((height/2) * ((144-this.yPos)/144))); //Camera against top wall
    else if(this.yPos > 410)
      translate(0, height/2 + ((height/2) * ((this.yPos-410)/144))); //Camera against bottom wall
    else
      translate(0, height/2);
    
    imageMode(CENTER);
    if(aiming && this.ammo > 0)
    {
      pushMatrix();
      int tempX = 0;
      //Right
      if(this.direction >= -PI/4 && this.direction <= PI/4)
      {
        translate(0, -40);
        rotate(direction);
        if(shooting)
        {
          tempX = 512;
          int temp = timer;
          timer = millis();
          shootTimer += timer - temp;
          if(shootTimer >= 1000)
          {
            shooting = false;
            shootTimer = 0;
            aiming = false;
          }
        }
        else
          tempX = 448;
        image(playerTop.get(tempX, 0, 64, 64), 1, -3, peopleSize*scaler, peopleSize*scaler);
      }
      //Up
      else if(this.direction > -3*PI/4 && this.direction < -PI/4)
      {
        translate(0, -38);
        rotate(direction +PI/2);
        if(shooting)
        {
          tempX = 512;
          int temp = timer;
          timer = millis();
          shootTimer += timer - temp;
          if(shootTimer >= 1000)
          {
            shooting = false;
            shootTimer = 0;
            aiming = false;
          }
        }
        else
          tempX = 448;
        image(playerTop.get(tempX, 64, 64, 64), 0, -10, peopleSize*scaler, peopleSize*scaler);
      }
      //Left
      else if(this.direction >= 3*PI/4 || this.direction <= -3*PI/4)
      {
        translate(0, -40);
        rotate(direction + PI);
        if(shooting)
        {
          tempX = 512;
          int temp = timer;
          timer = millis();
          shootTimer += timer - temp;
          if(shootTimer >= 1000)
          {
            shooting = false;
            shootTimer = 0;
            aiming = false;
          }
        }
        else
          tempX = 448;
        image(playerTop.get(tempX, 128, 64, 64), 0, -3, peopleSize*scaler, peopleSize*scaler);
      }
      //Down
      else
      {
        translate(0, -40);
        rotate(direction - PI/2);
        if(shooting)
        {
          tempX = 512;
          int temp = timer;
          timer = millis();
          shootTimer += timer - temp;
          if(shootTimer >= 1000)
          {
            shooting = false;
            shootTimer = 0;
            aiming = false;
          }
        }
        else
          tempX = 448;
        image(playerTop.get(tempX, 192, 64, 64), 0, 10, peopleSize*scaler, peopleSize*scaler);
      }
      popMatrix();
    }
    else
    {
      
      float modifier = 1.0f;
      if(exhausted)
        modifier = 0.75f;
      
      if(mDirection == 0) //RIGHT
      {
        if(mRight)
        {
          int temp = runTime;
          runTime = millis();
          runTimeTracker += runTime - temp;
        if(runTimeTracker*modifier >= 600)
          runTimeTracker = 0;
        int temp2 = (PApplet.parseInt(runTimeTracker*modifier) / 100)+1;
          //println(temp2);
          image(playerTop.get(64*temp2,0,64,64), 2, -32, peopleSize*scaler, peopleSize*scaler);
        }
        else
          image(playerTop.get(0,0,64,64), 2, -32, peopleSize*scaler, peopleSize*scaler);
      }
      else if(mDirection == 1) //UP
      {
        if(mUp)
        {
          int temp = runTime;
          runTime = millis();
          runTimeTracker += runTime - temp;
        if(runTimeTracker*modifier >= 600)
          runTimeTracker = 0;
        int temp2 = (PApplet.parseInt(runTimeTracker*modifier) / 100)+1;
          //println(temp2);
          image(playerTop.get(64*temp2,64,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
        }
        else
          image(playerTop.get(0,64,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
      }
      else if(mDirection == 2) //LEFT
      {
        if(mLeft)
        {
          int temp = runTime;
          runTime = millis();
          runTimeTracker += runTime - temp;
        if(runTimeTracker*modifier >= 600)
          runTimeTracker = 0;
        int temp2 = (PApplet.parseInt(runTimeTracker*modifier) / 100)+1;
          //println(temp2);
          image(playerTop.get(64*temp2,128,64,64), -4, -32, peopleSize*scaler, peopleSize*scaler);
        }
        else
          image(playerTop.get(0,128,64,64), -4, -32, peopleSize*scaler, peopleSize*scaler);
      }
      else if(mDirection == 3) // DOWN
      {
        if(mDown)
        {
          int temp = runTime;
          runTime = millis();
          runTimeTracker += runTime - temp;
        if(runTimeTracker*modifier >= 600)
          runTimeTracker = 0;
        int temp2 = (PApplet.parseInt(runTimeTracker*modifier) / 100)+1;
          //println(temp2);
          image(playerTop.get(64*temp2,192,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
        }
        else
          image(playerTop.get(0,192,64,64), 0, -32, peopleSize*scaler, peopleSize*scaler);
      }
    }
    popMatrix();
  }
  
  //Player movement
  public void movement(float xChange, float yChange)
  {
    PVector change = new PVector(xChange,yChange,0);
    if(exhausted)
    {
      xChange = 0.75f*xChange;
      yChange = 0.75f*yChange;
    }
    
    //Wall collision and correction
    for(int i = 0; i < walls.size(); i++)
    {
      change = collision(walls.get(i).getHitbox(), this.hBox, change.x, change.y, change.z, walls.get(i).getDirection());
      xChange = change.x;
      yChange = change.y;
    }
    
    for(int i = 0; i < enemies.size(); i++)
    {
      if(enemies.get(i).getDead() == false)
      {
        change = collision(enemies.get(i).getHitbox(), this.hBox, change.x, change.y, change.z, 0);
        xChange = change.x;
        yChange = change.y;
      }
    }
    change.z = 0;
    //Zone Transition Collision
    for(int i = 0; i < transitions.size(); i++)
    {
      change = collision(transitions.get(i), this.hBox, change.x, change.y, change.z, 0);
      if(change.z == 1){
        
        if(nextZone != transitions.get(i).getZone() && gameState == 0){
          zoneTransition = true;
          
          nextZone = transitions.get(i).getZone();
          nextZoneChanged = true;
          //println("nzt1");
          //println("nextZone is " + nextZone + " from the transition");
          nextPlayerX = transitions.get(i).getNextXPos();
          nextPlayerY = transitions.get(i).getNextYPos();
          transitions.clear();
          siberia.stop();
          theme.stop();
        }
        
        
      }
    }
    
    //Map boundary collision and correction
    if(this.xPos + xChange > 1120 || this.xPos + xChange < 0)
      xChange = 0;
    if(this.yPos + yChange > 544 || this.yPos + yChange < 0)
      yChange = 0;
    if(abs(xChange) + abs(yChange) >= 1.4f*speed)
    {
      xChange = xChange * 0.7f;
      yChange = yChange * 0.7f;
    }
    this.xPos += xChange;
    this.yPos += yChange;
        
    //Pickups
    for(int i = 0; i < pickups.size(); i++)
    {
      change = collision(pickups.get(i).getHitbox(), this.hBox, change.x, change.y, change.z, pickups.get(i).getDirection());
      if(change.z == 1)
      {
        pickups.get(i).activate();
        pickupSound.play();
        pickups.remove(i);
        i--;
      }
    }
    
    //Hitbox placement
    this.hBox.setXPos(this.xPos);
    this.hBox.setYPos(this.yPos);
  }
  
  public void cameraMove()
  {
   if(this.xPos < 256)
      cameraX = 0;
    else if(this.xPos > 864)
      cameraX = 608;
    else
      cameraX = this.xPos-256;
    
    if(this.yPos < 144)
      cameraY = 0;
    else if(this.yPos > 400)
      cameraY = 256;
    else
      cameraY = this.yPos-144; 
  }
  
  //GETTERS AND SETTERS
  public float getXPos(){
    return this.xPos;}
  public float getYPos(){
    return this.yPos;}
  public float getDir(){
    return this.direction;}
  public float getWidth(){
    return this.sizeW;}
  public float getHeight(){
    return this.sizeH;}
  public float getMaxHealth(){
    return this.maxHealth;}
  public float getCurrentHealth(){
    return this.currentHealth;}
  public float getMaxStamina(){
    return this.maxStamina;}
  public float getCurrentStamina(){
    return this.currentStamina;}
  public float getCurrentTemp(){
    return this.temperature;}
  public int getCurrentAmmo(){
    return this.ammo;}
  public Hitbox getHitbox(){
    return this.hBox;}
    
  public void setX(float x){
    this.xPos = x;}
  public void setY(float y){
    this.yPos = y;}
  public void setDir(float dir){
    this.direction = dir;}
  public void setMDir(int dir){
    this.mDirection = dir;}
  public void setHealth(float health){
    this.currentHealth = health;}
  public void setStamina(float stamina){
    this.currentStamina = stamina;
    if(this.currentStamina > this.maxStamina)
      this.currentStamina = this.maxStamina;}
  public void setCurrentAmmo(int ammo){
    this.ammo = ammo;}
}
//Projectile class

class Projectile
{
  private float xPos;
  private float yPos;
  private float damage;
  private float speed;
  private float xVector;
  private float yVector;
  private float sizeW;
  private float sizeH;
  private String type;
  private Hitbox hBox;
  
  Projectile()
  {
    this.xPos = 0;
    this.yPos = 0;
    this.damage = 0;
    this.speed = 3.5f;
    this.xVector = 1;
    this.yVector = 0;
    this.sizeW = 10;
    this.sizeH = 10;
    this.type = "neutral";
    this.hBox = new Hitbox(this.xPos, this.yPos, this.sizeW, this.sizeH, 0, this.type);
  }
  
  
  Projectile(float x, float y, float d, float s, float xV, float yV, float w, float h, String t)
  {
    this.xPos = x;
    this.yPos = y;
    this.damage = d;
    this.speed = s;
    this.xVector = xV;
    this.yVector = yV;
    this.sizeW = w;
    this.sizeH = h;
    this.type = t;
    this.hBox = new Hitbox(this.xPos, this.yPos, this.sizeW, this.sizeH, 0, this.type);
  }
  
  //Display projectile
  public void display()
  {
    pushMatrix();
    translate((width*(this.xPos-cameraX)/512), height*(this.yPos-cameraY)/288);
    this.hBox.setXPos(this.xPos);
    this.hBox.setYPos(this.yPos);
    this.xPos = this.xPos + this.xVector*this.speed;
    this.yPos = this.yPos + this.yVector*this.speed;
    ellipseMode(CENTER);
    noStroke();
    fill(100);
    if(this.type.equals("hostile_damage"))
    {
      imageMode(CENTER);
      translate(0,-64);
      rotate(atan2(this.yVector,this.xVector));
      image(bullet, 0,0, bullet.width*scaler*.5f, bullet.height*scaler*.5f);
      
      //fill(255,100,0);
      //ellipse(0,-64, this.sizeW*scaler, this.sizeH*scaler);
    }
    if(this.type.equals("friendly_damage"))
    {
      imageMode(CENTER);
      translate(0, -60);
      rotate(atan2(this.yVector,this.xVector));
      image(arrow, 0, 0, arrow.width*scaler*.75f, arrow.height*scaler*.75f);
    }
    
    if(hitBoxMode)
      this.hBox.displayBox();
    popMatrix();
  }
  
  //GETTERS AND SETTERS
  public float getXPos(){
    return this.xPos;}
  public float getYPos(){
    return this.yPos;}
  public float getXVector(){
    return this.xVector;}
  public float getYVector(){
    return this.yVector;}
  public Hitbox getHitbox(){
    return this.hBox;}
  public String getType(){
    return this.type;}
  public float getDamage(){
    return this.damage;}
}
//Ranged Weapon Class

class RangedWeapon extends Weapon
{
  private float speed;
  private String type;
  private float sizeW;
  private float sizeH;
  private String id;
  
  RangedWeapon()
  {
    super(0);
    this.speed = 1;
    this.type = "neutral";
    this.sizeW = 10;
    this.sizeH = 10;
    this.id = "bow";
  }
  
  RangedWeapon(int dam, float sp, String t, float w, float h)
  {
    super(dam);
    this.speed = sp;
    this.type = t;
    this.sizeW = w;
    this.sizeH = h;
    this.id = "bow";
  }
  
  public void addProjectile(float x, float y, float xVector, float yVector)
  {
    projectiles.add(new Projectile (x, y, super.damage, this.speed, xVector, yVector, this.sizeW, this.sizeH, this.type));
  }
  
  public String getID(){
    return this.id;}
}
//Save

//Can be prompted by user in the menu or a checkpoint

public void save(){
//TODO: Make sure all the values are updated before you save
saveWriter = createWriter("data/save.txt");
saveWriter.println("chapter=" + currentChapter);
saveWriter.println("zone=" + currentZone);
saveWriter.println("xpos=" + nextPlayerX);
saveWriter.println("ypos=" + nextPlayerY);
saveWriter.println("health=" + saveHealth);
saveWriter.println("stamina=" + saveStamina);
saveWriter.println("temp=" + saveTemp);
saveWriter.println("ammo=" + saveAmmo);
saveWriter.println("last_cutscene=" + last_cutscene);
saveWriter.println("weapon=" + activeWeapon.getID());
saveWriter.println("dynamite=" + dynamite);
saveWriter.println("detonator=" + detonator);
saveWriter.println("rope=" + rope);
saveWriter.println("collar=" + collar);
saveWriter.println("seal1=" + seal1);
saveWriter.println("seal2=" + seal2);
saveWriter.println("whale=" + whale);
saveWriter.println("sap=" + sap);
saveWriter.flush();
saveWriter.close();
//println("Save completed");
saveCompleted = true;
currentTime = millis();
}

public void printSave(boolean saved){
  if((millis()- currentTime) > 5000){ //Wait 5 seconds to do away with the Saved Successfully print
    saved = false;
    saveCompleted = false;
  }
  
  
  if(saved == true){
    pushMatrix();
    noStroke();
    rectMode(CENTER);
    textSize(20);
    fill(0,80);
    rect(width-115,0,350,100);
    fill(255);
    textAlign(CENTER,TOP);
    text("Saved Successfully", width-145, 20);
    popMatrix();
  }
}

public void newSave(){
//Reset values
currentChapter = "1";
currentZone = "1";
nextPlayerX = 96;
nextPlayerY = 480;
saveHealth = 100;
saveStamina = 100;
saveTemp = 100;
saveAmmo = 0;
last_cutscene = "0";
activeWeapon = none;
dynamite = 0;
detonator = 0;
rope = 0;
collar = 0;
seal1 = 0;
seal2 = 0;
whale = 0;
sap = 0;
saveStamina = 100;

player.setStamina(saveStamina);

nextZone = "1";
println("nextZone is 1 form newsave");
nextZoneChanged = false;
//println("nzf2");

saveWriter = createWriter("data/save.txt");
saveWriter.println("chapter=" + currentChapter);
saveWriter.println("zone=" + currentZone);
saveWriter.println("xpos=" + nextPlayerX);
saveWriter.println("ypos=" + nextPlayerY);
saveWriter.println("health=" + saveHealth);
saveWriter.println("stamina=" + saveStamina);
saveWriter.println("temp=" + saveTemp);
saveWriter.println("ammo=" + saveAmmo);
saveWriter.println("last_cutscene=" + last_cutscene);
saveWriter.println("weapon=" + activeWeapon.getID());
saveWriter.println("dynamite=" + dynamite);
saveWriter.println("detonator=" + detonator);
saveWriter.println("rope=" + rope);
saveWriter.println("collar=" + collar);
saveWriter.println("seal1=" + seal1);
saveWriter.println("seal2=" + seal2);
saveWriter.println("whale=" + whale);
saveWriter.println("sap=" + sap);
saveWriter.flush();
saveWriter.close();
println("Save completed");
saveCompleted = true;
currentTime = millis();
}
//Wall class

class Wall
{
  private float xPos;
  private float yPos;
  private float sizeW;
  private float sizeH;
  private float direction;
  private Hitbox hBox;
  
  Wall(float x, float y, float w, float h, float dir)
  {
    this.xPos = x;
    this.yPos = y;
    this.sizeW = w;
    this.sizeH = h;
    this.hBox = new Hitbox(x,y,w,h, dir, "wall");
    this.direction = dir;
  }
  
  //Displays the wall hitbox
  public void displayWall()
  {
    pushMatrix();
    
    translate((this.xPos-cameraX)*scaler,(this.yPos-cameraY)*scaler);
    rotate(this.direction);
    this.hBox.setXPos(this.xPos);
    this.hBox.setYPos(this.yPos);
    rectMode(CENTER);
    //fill(0); //black
    noStroke();
    
    rect(0, 0,this.sizeW*scaler,this.sizeH*scaler);
    
    popMatrix();
    if(hitBoxMode)
      this.hBox.displayBox();
  }
  
  //GETTERS AND SETTERS
  public float getXPos(){
    return this.xPos;}
  public float getYPos(){
    return this.yPos;}
  public float getWidth(){
    return this.sizeW;}
  public float getHeight(){
    return this.sizeH;}
  public float getDirection(){
    return this.direction;}
  public Hitbox getHitbox(){
    return this.hBox;}
  
  public void setXPos(float x){
    this.xPos = x;}
  public void setYPos(float y){
    this.yPos = y;}
    
  public void print(){
    println("Wall:");
    println("x = " + this.xPos);
    println("y = " + this.yPos);
    println("width = " + this.sizeW);
    println("height = " + this.sizeH);
    println("direction = " + this.direction);
  }
}
//Weapon superclass

class Weapon
{
  private int damage;
  private String id;
  
  Weapon()
  {
    this.damage = 0;
    this.id = "none";
  }
  Weapon(int da)
  {
    this.damage = da;
    this.id = "none";
  }
  
  //GETTERS AND SETTERS
  public int getDam(){
    return this.damage;}
  public void setDam(int da){
    this.damage = da;}
  public String getID(){
    return this.id;}
}
//Zone class

class Zone
{
  ArrayList<Wall> walls = new ArrayList<Wall>();
  ArrayList<Hitbox> transitionZones = new ArrayList<Hitbox>();
  ArrayList<Pickup> pickups = new ArrayList<Pickup>();
  ArrayList<Enemy> enemies = new ArrayList<Enemy>();
  private String name;
  Zone(String name){
    this.name = name;
  }
  
  //Getters
  public ArrayList<Wall> getWalls(){
    return this.walls;}
  public ArrayList<Hitbox> getTransitionZones(){
    return this.transitionZones;}
  public ArrayList<Pickup> getPickups(){
    return this.pickups;}
  public ArrayList<Enemy> getEnemies(){
    return this.enemies;}
  public String getZoneName(){
    return this.name;} //I couldn't use getName because it is a processiing library method already
    
  //Setters
  public void setWalls(ArrayList<Wall> walls){
    this.walls = walls;}
  public void addWall(Wall newWall){
    this.walls.add(newWall);}
  public void setTransitionZones(ArrayList<Hitbox> transitionZones){
    this.transitionZones = transitionZones;}
  public void addTransitionZone(Hitbox newTransition){
    this.transitionZones.add(newTransition);}
  public void setPickups(ArrayList<Pickup> pickups){
    this.pickups = pickups;}
  public void addPickup(Pickup newPickup){
    this.pickups.add(newPickup);}
  public void setEnemies(ArrayList<Enemy> enemies){
    this.enemies = enemies;}
  public void addEnemy(Enemy newEnemy){
    this.enemies.add(newEnemy);}
  public void setZoneName(String name){
    this.name = name;}
    
  //Print
  public void print(){
    println("Zone " + this.name + ":");
    //Walls
    for(int i = 0; i < this.walls.size(); i++){
      this.walls.get(i).print();
    }
    //TransitionZones
    for(int i = 0; i < this.transitionZones.size(); i++){
      this.transitionZones.get(i).print();
    }
    //Pickups
    for(int i = 0; i < this.pickups.size(); i++){
      println(this.pickups.get(i).getID());
    }
    //Enemies
    for(int i = 0; i < this.enemies.size(); i++){
      this.enemies.get(i).print();
    }
  }
}

boolean deadScreenFinished = false;
float lastTime;

public void deadScreen(){
      
      if(transparency < 255){ //Fade to white
          transparency += transparencyIncrement;
          rectMode(CORNER);
          fill(164,13,13, transparency);
          rect(0, 0, width, height);
          fill(255, 0, 0, transparency);
          textSize(100);
          textAlign(CENTER,CENTER);
          text(gameOverStatement, width/2.0f, height/2.0f);
          if(transparency == 255){
            lastTime = millis();
          }
       }
       else if(transparency == 255){ //Fade from white to new zone
       
          if(millis() - lastTime > 3000){
            deadScreenFinished = true;
            theme.stop();
          }
       
       
          if(deadScreenFinished){
            transparency2 -= transparencyIncrement;
            mainMenu();
            rectMode(CORNER);
            fill(164, 13, 13, transparency2);
            rect(0, 0, width, height);
            fill(255, 0 , 0, transparency2);
            textSize(100);
            textAlign(CENTER,CENTER);
            text(gameOverStatement, width/2.0f, height/2.0f);
            if(transparency2 == 0){ // To force the next else statement after fade is done
              transparency = 256;
            }            
          }
          else{
            fill(164,13,13, transparency);
            rect(0, 0, width, height);
            fill(255, 0, 0);
            textSize(100);
            textAlign(CENTER,CENTER);
            text(gameOverStatement, width/2.0f, height/2.0f);
          }
          
       }
       else{ //reset variables
          transparency = 0;
          transparency2 = 255;
          gameState = 2;
          //Switch to gameplay at appropriate zone
          loadSave();
          deadScreenFinished = false;
          timeDead = 0;
          //deadTimer = 0;
          gameState = 2;
          player.setHealth(100);
          dead = false;
          //println("dead is false in timeDead");
          projectiles.clear();
          int cc = Integer.parseInt(currentChapter);
          cc--;
          int cz = Integer.parseInt(currentZone);
          cz--;
          for(int i = 0; i < chapters.get(cc).getZones().get(cz).getEnemies().size(); i++){
            chapters.get(cc).getZones().get(cz).getEnemies().get(i).setAlert(false);
            chapters.get(cc).getZones().get(cz).getEnemies().get(i).setShooting(false);
          }
       }
  
  
  
  
}
//Loading info for cutscene using the configure file



public void loadCutScene(){
  int cid = Integer.parseInt(last_cutscene);
  
  println("cid=" + cid);
  int cc = Integer.parseInt(currentChapter);
  
  cc--;
  //println("cc=" + cc);
  if(last_cutscene.equals("-1")){
    cid = 1;
    last_cutscene = "0";
  }
  CutScene currentCutScene = chapters.get(cc).getCutScenes().get(cid);
  nextZone = currentCutScene.getNextZone();

  //println("nextZone turned to " + nextZone + "in the loadCutscene");
  cc++;
  playCutScene(cc, currentCutScene);

}



public void loadSave(){
  
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
    String weaponID = saveReader.readLine().substring(7);
    if(weaponID.equals("bow")){
      activeWeapon = bow;
      playerTop = bowTop;}
    else{
      activeWeapon = none;
      playerTop = fistTop;}
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
    activeWeapon = none;
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
  
public void loadZone(){
  if(nextZone.equals("null")){
    println("ERROR: nextZone == NULL");
  }
  else if(nextZone.equals("-1")){//Zone to Cutscene
    gameState = 1;


  }
  else if(nextZone.equals("-3")){
    //end game
    gameState = 2;
    zoneTransition = true;
  }
  else if(nextZone.equals("-2")){//zone to next chapter's zone
    //playerNextX = xpos
    //ypos
    //println("nextzone is -2");
    last_cutscene = "-1";
    currentChapter = Integer.toString(Integer.parseInt(currentChapter) + 1);
    println("currentChapter is " + currentChapter);
    nextZone = "1";
    //println("Next zone is 1 from loadzone->else if");
    println("lastcutscnee:" + last_cutscene);
    gameState = 1;
    nextZoneChanged = false;
    //println("nzf4");
    loadZone();

  }
  else{
    //println("next zone is " + nextZone);
    //Update game state
    //gameState = 0;

    saveCompleted = false;
    
    //Landscape
    horizonView = loadImage("Ch" + currentChapter + "/Zones/" + nextZone + "_Horizon.png");
    background = loadImage("Ch" + currentChapter + "/Zones/" + nextZone + "_Background.png");
    foreground = loadImage("Ch" + currentChapter + "/Zones/" + nextZone + "_Foreground.png");
    
    currentZone = nextZone;
    
    //Player position
    if( pause == false){
      player.setX(nextPlayerX);
      player.setY(nextPlayerY);
      player.movement(0,0); //recalculate the camera position because of new player location
      
    }
    
    //Walls
    walls.clear();
    int currentCh = Integer.parseInt(currentChapter);
    int nextZ = Integer.parseInt(nextZone);
    Chapter thisChapter = chapters.get(currentCh-1);
    
    
    Zone thisZone = thisChapter.getZones().get(nextZ - 1);
    ArrayList <Wall> thisWall =  thisZone.getWalls();
    
    for(int i = 0; i < thisWall.size(); i++){
      walls.add(thisWall.get(i));
    }

    //transitions
    transitions.clear();
    ArrayList <Hitbox> thisTransitions = thisZone.getTransitionZones();
    for(int i = 0; i < thisTransitions.size(); i++){
      transitions.add(thisTransitions.get(i));
    }

    //Pickups
    pickups.clear();
    ArrayList <Pickup> thisPickup = thisZone.getPickups();
    for(int i = 0; i < thisPickup.size(); i++){
      pickups.add(thisPickup.get(i));
    }
    
    //Enemies
    enemies.clear();
    ArrayList <Enemy> thisEnemy = thisZone.getEnemies();
    for(int i = 0; i < thisEnemy.size(); i++){
      enemies.add(thisEnemy.get(i));
      //println("Enemy " + i + " alert is: " + thisEnemy.get(i).getAlert());
    }
    //chapterKeys = 0;
    //reqKeys = 1;
    

    pause = false;
    zoneTransition = true;

  }

}

  
  public void settings() {  fullScreen();  noSmooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Main" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
