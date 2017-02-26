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

//Fade trackers

//Sound

//Images

//Fonts

//Zones

//Menu
boolean pause;
boolean gameStart;
boolean dead;
float deadTimer;

/*
Button gameStart;    //Start/continue
Button gameOptions;
Button optionsBack;
Button pauseContinue;
Button pauseQuit;
*/

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
//StaminaPickup stamina20;
//ArrayList<Pickup> pickups = new ArrayList<Pickup>();

//Enemies
//ArrayList<Enemy> enemies = new ArrayList<Enemy>();

void setup()
{
  //Screen Resolution
  fullScreen();
  //backgroundImage
  frameRate(60);
  cursor(CROSS);
  
  //Fonts
  
  //Images
  
  //Intro?
  
  //Menu
  
  //Options
  
  pause = false;
  gameStart = true; //SWITCH TO FALSE WHEN MENU IS ADDED
  dead = false;
  deadTimer = 0;
  
  //Fades
  
  //Load images
  
  //Play sounds
  //Menu/ Game music
  
  
  //Player values
  player = new Player(width/2, height/2, direction, 200, 32, 32, "player");
  speed = 5.0;
  direction = 0;
  knifeDamage = 50;
  knifeReach = 70;
  bowDamage = 100;
  arrowSpeed = 15.0;
  
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
  
  //BUTTON INITIALIZATION
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
  //MENU SHIT
  
  //IN-GAME
  if(gameStart == true)
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

//DISPLAY HUD
void displayHUD()
{
  //Health bar
  //Stamina bar
  //Amount of food
  //Temperature
}

//CORE GAME LOOP
//DRAW FUNCTION
void draw()
{
  //MUSIC CONTROL
  
  //INTRO?
  
  //MENUS
  
  if(pause == false)
  {
    //DRAW BACKGROUND ENVIRONMENT
    pushMatrix();
    translate(width/2,height/2);
    rectMode(CENTER);
    fill(255);
    noStroke();
    rect(0,0,width,height);
    popMatrix();
    
    //Player position update
    if(keyPressed)
    {
      if(keyCode == UP || key == 'w' || key == 'W')
        mUp = true;
      if(keyCode == DOWN || key == 's' || key == 'S')
        mDown = true;
      if(keyCode == LEFT || key == 'a' || key == 'A')
        mLeft = true;
      if(keyCode == RIGHT || key == 'd' || key == 'D')
        mRight = true;
    }  
    if(mUp == true)
      player.movement(0, -1*speed);
    if(mDown == true)
      player.movement(0, speed);
    if(mLeft == true)
      player.movement(-1*speed, 0);
    if(mRight == true)
      player.movement(speed, 0);
    
    player.setDir(mouseAngle());
    //Enemy behavior and movement update
      
    //Wall display
    for(int i = 0; i < walls.size(); i++)
      walls.get(i).displayWall();
    
    //Test turret
    
    //Pickup respawn?
    
    //Pickup Display
    //for(int i = 0; i < pickups.size(); i++)
      //pickups.get(i).display();
      
    //Player and Enemy display
    player.display();
    //for(int i = 0; i < enemies.size(); i++)
      //enemies.get(i).display();
    
    //Projectile Display
    //for(int i = 0; i < projectileSpawners.size(); i++)
      //projectileSpawners.get(i).displayProjectiles();
    
    //HUD Display
    displayHUD();
    deadCheck(player);
    
  }
  else if(dead == true)
  {
    //stop music
    //play death noise and animation
    
    //"Continue","Main menu","Exit game"
  }
}