
boolean deadScreenFinished = false;
float lastTime;

void deadScreen(){
      
      if(transparency < 255){ //Fade to white
          transparency += transparencyIncrement;
          rectMode(CORNER);
          fill(164,13,13, transparency);
          rect(0, 0, width, height);
          fill(255, 0, 0, transparency);
          textSize(100);
          textAlign(CENTER,CENTER);
          text(gameOverStatement, width/2.0, height/2.0);
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
            text(gameOverStatement, width/2.0, height/2.0);
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
            text(gameOverStatement, width/2.0, height/2.0);
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
          deadTimer = 0;
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