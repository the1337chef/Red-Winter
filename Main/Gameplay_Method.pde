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
    imageMode(CORNER);
    //fill(255);
    noStroke();
    image(zoneGround,-cameraX*scaler,-cameraY*scaler,zoneGround.width*scaler,zoneGround.height*scaler);
    popMatrix();
    
    if(zoneTransition == true){ //For zone transitions

     if(transparency < 255){ //Fade to white
        transparency += transparencyIncrement;
        fill(0, 0, 0, transparency);
        rect(0, 0, width, height);
     }
     else if(transparency == 255){ //Fade from white to new zone
         
         //add switch statement of the variety of zones to transition to
         if( nextZone.equals("1")){
          testZone();
         }
         else if( nextZone.equals("2")){
           testZone2();
         }
         else{
           println("ERROR: nextZone == NULL");
         }
        transparency2 -= transparencyIncrement;
        fill(0, 0, 0, transparency2);
        rect(0, 0, width, height);
        if(transparency2 == 0){ // To force the next else statement after fade is done
          transparency = 256;
        }
     }
     else{ //reset variables
        zoneTransition = false;
        zoneTransition2 = false;
        transparency = 0;
        transparency2 = 255;
     }
    }
    
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
    
    if(hitBoxMode){
      //Wall display
      for(int i = 0; i < walls.size(); i++)
        walls.get(i).displayWall();
        
      //Transition Zone display
      for(int i = 0; i < transitions.size(); i++)
        transitions.get(i).displayBox();
    }
    
    //Test turret
    
    //Pickup respawn?
    
    //Pickup Display
    //for(int i = 0; i < pickups.size(); i++)
      //pickups.get(i).display();
      
    //Player and Enemy display
    if(zoneTransition == false){
      player.display();
    }
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