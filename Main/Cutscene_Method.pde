//Cutscene method

int cutSceneNumber = 1;
PImage layer2;
boolean layer2Exists = false;
PImage layer3;
boolean layer3Exists = false;

//Sound (Maybe put in seperate place)
SoundFile file;
boolean soundPlayed = false;


void cutscene()
{
  //Display Cutscene image
  switch (cutSceneNumber){
    case 1:  cutScene = loadImage("Ch1-1.png");
             if(soundPlayed == false){
               file = new SoundFile(this, "jetSound.mp3");
               file.play();
               soundPlayed = true;
             }
             break;
    case 2:  file.stop();
             soundPlayed = false;
             cutScene = loadImage("Ch1-2.png");
             break;
    case 3:  cutScene = loadImage("ch1-3-1.png");
             layer2 = loadImage("ch1-3-2.png");
             layer2Exists = true;
             break;
    case 4:  cutScene = loadImage("ch1-3-1.png");
             layer2 = loadImage("ch1-3-2.png");
             layer2Exists = true;
             layer3 = loadImage("ch1-3-3.png");
             layer3Exists = true;
             break;
    case 5:  cutScene = loadImage("Ch1-4.png");
             break;
    case 6:  cutSceneNumber = 1;
             gameState = 0;
             break;
    default: println("ERROR: cutSceneNumber not valid");
             break;
  }
  
  image(cutScene, 0, 0, width, height);
  if(layer2Exists){
    image(layer2, 0, 0, width, height);
    layer2Exists = false;
  }
  if(layer3Exists){
    image(layer3, 0, 0, width, height);
    layer3Exists = false;
  }
  
  //Play noise if included
  
  
  //Check time for image
  
  
  //gameState = 0;
  cursor(CROSS);
}