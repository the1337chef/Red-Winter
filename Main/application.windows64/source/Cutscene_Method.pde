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

void playCutScene(int ch, CutScene cutscene){

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

void nextSubScene(){
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