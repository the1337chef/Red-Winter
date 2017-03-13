


void cutSceneTransition(){
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
          fill(fillColor, fillColor, fillColor, transparency2);
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
          cutSceneTransitionPlayed = true;
       }
  }
  popMatrix();
}