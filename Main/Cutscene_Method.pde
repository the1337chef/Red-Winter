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


//void cutscene()
//{
//  //Display Cutscene image
//  switch (subSceneIndex){
//    case 1:  cutScene = loadImage("Ch1-1.png");
//             if(soundPlayed == false){
//               file = new SoundFile(this, "jetSound.mp3");
//               file.play();
//               soundPlayed = true;
//             }
//             break;
//    case 2:  file.stop();
//             soundPlayed = false;
//             cutScene = loadImage("Ch1-2.png");
//             break;
//    case 3:  cutScene = loadImage("ch1-3-1.png");
//             layer2 = loadImage("ch1-3-2.png");
//             layer2Exists = true;
//             break;
//    case 4:  cutScene = loadImage("ch1-3-1.png");
//             layer2 = loadImage("ch1-3-2.png");
//             layer2Exists = true;
//             layer3 = loadImage("ch1-3-3.png");
//             layer3Exists = true;
//             break;
//    case 5:  cutScene = loadImage("Ch1-4.png");
//             break;
//    case 6:  subSceneIndex = 1;
//             gameState = 0;
//             break;
//    default: println("ERROR: subSceneIndex not valid");
//             break;
//  }
  
//  image(cutScene, 0, 0, width, height);
//  if(layer2Exists){
//    image(layer2, 0, 0, width, height);
//    layer2Exists = false;
//  }
//  if(layer3Exists){
//    image(layer3, 0, 0, width, height);
//    layer3Exists = false;
//  }
  
//  //Play noise if included
  
  
//  //Check time for image
  
  
//  //gameState = 0;
//  cursor(CROSS);
//}

void playCutScene(int ch, CutScene cutscene){
  //TODO:establish layers booleans

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
      println(source);
      layer1 = loadImage(source);
      println("painting layer: " + layerNum); 
      image(layer1, 0, 0, width, height);
    }
    //TODO:do we need to keep repainting them on the screen if they are static?
    //TODO:Images might not be able to be overwritten
    
    //Play noise if included
    for(int i = 0; i < cutscene.getSounds().get(subSceneIndex); i++){
      int soundNum = i+1;
      println("Sound num:" + soundNum);
      int subSceneIndexNum = subSceneIndex + 1;
      String source = "Ch" + ch + "/" + ch + "-" + cutscene.getId() + "/" + ch + "-" + cutscene.getId() + "-" + subSceneIndexNum;
      if( cutscene.getLayers().get(subSceneIndex) > 1){
        source = source + "-" + soundNum;
      }
      source = source + ".mp3";
      if(soundPlayed == false){
        println("Playing Sound");
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
    println("pastTime :" + pastTime);
    println("currentTime :" + millis());
    //Check time for image
    if(millis() - pastTime > cutscene.getDurations().get(subSceneIndex)){
      nextSubScene();
    }

  }
  else{
    gameState = 0;
    subSceneIndex = 0;
    timeUpdated = false;
    soundPlayed = false;
  }
  
  cursor(CROSS);
}

void nextSubScene(){
      subSceneIndex++;
      timeUpdated = false;
      soundPlayed = false;
      soundFile.stop();
}