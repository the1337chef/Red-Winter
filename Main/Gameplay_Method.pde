//Gameplay Method

void gamePlay()
{
 //MUSIC CONTROL
  
  //INTRO?
  
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
      if(keyCode == UP || key == 'w' || key == 'W')
        mUp = true;
      if(keyCode == DOWN || key == 's' || key == 'S')
        mDown = true;
      if(keyCode == LEFT || key == 'a' || key == 'A')
        mLeft = true;
      if(keyCode == RIGHT || key == 'd' || key == 'D')
        mRight = true;
    }  
    if(mUp == true){
      player.movement(0, -1*speed);
      player.setMDir(1);}
    if(mDown == true){
      player.movement(0, speed);
      player.setMDir(3);}
    if(mLeft == true){
      player.movement(-1*speed, 0);
      player.setMDir(2);}
    if(mRight == true){
      player.movement(speed, 0);
      player.setMDir(0);}
      
    player.setDir(mouseAngle());
    //Enemy behavior and movement update
    

    
    //Test turret
    
    //Pickup respawn?
    
    //Pickup Display
    for(int i = 0; i < pickups.size(); i++)
      pickups.get(i).display();
      
    //Player and Enemy display
    player.displayBottom();
    
    //for(int i = 0; i < enemies.size(); i++)
      //enemies.get(i).display();
    
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
          change = collision(walls.get(j).getHitbox(), projectiles.get(i).getHitbox(), change.x, change.y, change.z, walls.get(j).getDirection());
          if(change.z == 1)
          {
            projectiles.remove(i);
            removed = true;
            break;
          }
        }
        
        //Enemy Collision Check
        
        //Out of bounds Check
        if(removed == false)
        {
          if(projectiles.get(i).getXPos() < -50 || projectiles.get(i).getXPos() > 1170 ||
            projectiles.get(i).getYPos() < -50 || projectiles.get(i).getYPos() > 604)
            {
              projectiles.remove(0);
              removed = true;
            }
        }
        
        if(removed)
          i--;
        else
          projectiles.get(i).display();
      }
    }
    
    player.displayTop();
    
    if(cutSceneHalfWay){
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
      for(int i = 0; i < transitions.size(); i++)
        transitions.get(i).displayBox();
    }
    
    player.cameraMove();
    
    //HUD Display
    hud.updateValues(player.getCurrentHealth(), player.getCurrentStamina(), player.getCurrentTemp(), player.getCurrentAmmo());
    if(cutSceneHalfWay && !zoneTransition){
      hud.display();
    }
    deadCheck(player);
    
     if(zoneTransition == true){ //For zone transitions
      if(soundPlayed == false){
                 soundFile = new SoundFile(this, "ZoneTransition2.wav");
                 soundFile.play();
                 soundPlayed = true;
               }
    
    
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
     }
     else if(transparency == 255){ //Fade from white to new zone
         cutSceneHalfWay = true;
         //add switch statement of the variety of zones to transition to
        loadZone();
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
        zoneTransition2 = false;
        transparency = 0;
        transparency2 = 255;
        soundPlayed = false;
        save();
     }
     
     
    }
    
  }
  else if(dead == true)
  {
    //stop music
    //play death noise and animation
    
    //"Continue","Main menu","Exit game"
  }
  printSave(saveCompleted); //Prints if recently saved
}