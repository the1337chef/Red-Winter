//Cutscene method
PImage layer1;
int subSceneIndex = 0;
PImage layer2;
boolean layer2Exists = false;
PImage layer3;
boolean layer3Exists = false;

//Sound (Maybe put in seperate place)
SoundFile soundFile;
boolean soundPlayed = false;

float pastTime;
boolean timeUpdated = false;
boolean cutSceneTransitionPlayed = false;
boolean cutSceneHalfWay = false; //half the fade occured

void playCutScene(int ch, CutScene cutscene){
  //TODO:establish layers booleans


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
        if( cutscene.getLayers().get(subSceneIndex) > 1){
          source = source + "-" + soundNum;
        }
        source = source + ".mp3";
        //println(source);
        if(soundPlayed == false){
          //println("Playing Sound");
          soundFile = new SoundFile(this, source);
          soundFile.play();
          soundPlayed = true;
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
        soundFile.stop();
      }
      soundPlayed = false;
      cutSceneTransitionPlayed = false;
      save();
      loadZone();
      zoneTransition = true;
      resetValues();
      //println("reset in playCutScene last else");
    }
    
    cursor(CROSS);
  }
    cutSceneTransition();
}

void nextSubScene(){
      subSceneIndex++;
      timeUpdated = false;
      if(soundPlayed){
        soundFile.stop();
      }
      soundPlayed = false;
      
      //println("Next SubScene");
      
}