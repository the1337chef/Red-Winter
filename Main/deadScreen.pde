


void deadScreen(){
  
      if(transparency < 255){ //Fade to white
          transparency += transparencyIncrement;
          rectMode(CORNER);
          fill(255, 0, 0, transparency);
          rect(0, 0, width, height);
          
       }
       else if(transparency == 255){ //Fade from white to new zone
          transparency2 -= transparencyIncrement;
          mainMenu();
          fill(255, 0, 0, transparency2);
          rect(0, 0, width, height);
          if(transparency2 == 0){ // To force the next else statement after fade is done
            transparency = 256;
          }
       }
       else{ //reset variables
          transparency = 0;
          transparency2 = 255;
          gameState = 2;
       }
  
  
  
  
}