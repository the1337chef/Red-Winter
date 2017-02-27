//Gameplay Method

void gamePlay()
{
 //MUSIC CONTROL
  
  //INTRO?
  
  //MENUS
  
  if(pause == false)
  {
    //DRAW BACKGROUND ENVIRONMENT
    pushMatrix();
    translate(width/2,height/2);
    imageMode(CENTER);
    fill(255);
    noStroke();
    image(zoneGround,0,0,width,height);
    //rect(0,0,width,height);
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
    hud.updateValues(player.getCurrentHealth(), player.getCurrentStamina(), 
      player.getCurrentTemp(), player.getCurrentAmmo());
    hud.display();
    deadCheck(player);
    
  }
  else if(dead == true)
  {
    //stop music
    //play death noise and animation
    
    //"Continue","Main menu","Exit game"
  } 
}