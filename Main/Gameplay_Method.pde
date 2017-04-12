//Gameplay Method
boolean deathPlayed = false;
float savedTime = millis();
void gamePlay()
{
 //MUSIC CONTROL
 if(themePlayed){
   themePlayed = false;
   theme.amp(0.4);
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
          speed = 3.5 * (player.getCurrentStamina()/player.getMaxStamina());
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
          speed = 3.5 * (player.getCurrentStamina()/player.getMaxStamina());
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
          speed = 3.5 * (player.getCurrentStamina()/player.getMaxStamina());
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
          speed = 3.5 * (player.getCurrentStamina()/player.getMaxStamina());
          savedTime = millis();
        }
      }
    }  
    if(mUp == true){
      player.movement(0, -1*speed);
      if (player.getCurrentStamina() > 25 && !superspeed) {
        player.setStamina(player.getCurrentStamina()-0.05);
      }
      //else if(player.getCurrentStamina() < player.getMaxStamina() &&  exhausted){
        //player.setStamina(player.getCurrentStamina()+1);}
      player.setMDir(1);}
      
    if(mDown == true){
      player.movement(0, speed);
      if (player.getCurrentStamina() > 25 && !superspeed) {
        player.setStamina(player.getCurrentStamina()-0.05);
      }
      //else if(player.getCurrentStamina() < player.getMaxStamina() &&  exhausted){
        //player.setStamina(player.getCurrentStamina()+1);}
      player.setMDir(3);}
      
    if(mLeft == true){
      player.movement(-1*speed, 0);
      if (player.getCurrentStamina() > 25 && !superspeed) {
        player.setStamina(player.getCurrentStamina()-0.05);
      }
      //else if(player.getCurrentStamina() < player.getMaxStamina() &&  exhausted){
        //player.setStamina(player.getCurrentStamina()+1);}
      player.setMDir(2);}
      
    if(mRight == true){
      player.movement(speed, 0);
      if (player.getCurrentStamina() > 25 && !superspeed) {
        player.setStamina(player.getCurrentStamina()-0.05);
      }
      //else if(player.getCurrentStamina() < player.getMaxStamina() &&  exhausted){
        //player.setStamina(player.getCurrentStamina()+1);}
        
      player.setMDir(0);}
        
    if (mUp == false && mDown == false && mLeft == false && mRight == false) {
      if (player.getCurrentStamina() < player.getMaxStamina()) {
         player.setStamina(player.getCurrentStamina()+0.5); 
      }
    }
    
    if(superspeed) {
      speed = 8.0;
    }
      
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
                 transition.play();
                 
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