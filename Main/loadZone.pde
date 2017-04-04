  
void loadZone(){
  if(nextZone == "null"){
    println("ERROR: nextZone == NULL");
  }
  else if(nextZone == "-1"){//Zone to Cutscene
    gameState = 1;

  }
  else if(nextZone == "-2"){//zone to next chapter
    //playerNextX = xpos
    //ypos
    last_cutscene = "0";
    currentChapter = Integer.toString(Integer.parseInt(currentChapter) + 1);
    nextZone = "1";
    gameState = 1;
    
  }
  else{
    //println("next zone is " + nextZone);
    //Update game state
    gameState = 0;
    saveCompleted = false;
    //Landscape
    horizonView = loadImage("Ch" + currentChapter + "/Zones/" + nextZone + "_Horizon.png");
    background = loadImage("Ch" + currentChapter + "/Zones/" + nextZone + "_Background.png");
    foreground = loadImage("Ch" + currentChapter + "/Zones/" + nextZone + "_Foreground.png");
    
    currentZone = nextZone;
    
    //Player position
    if( pause == false){
      player.setX(nextPlayerX);
      player.setY(nextPlayerY);
      player.movement(0,0); //recalculate the camera position because of new player location
    }
    pause = false;
    
    //Walls
    walls.clear();
    int currentCh = Integer.parseInt(currentChapter);
    int nextZ = Integer.parseInt(nextZone);
    Chapter thisChapter = chapters.get(currentCh-1);
    Zone thisZone = thisChapter.getZones().get(nextZ - 1);
    ArrayList <Wall> thisWall =  thisZone.getWalls();
    
    for(int i = 0; i < thisWall.size(); i++){
      walls.add(thisWall.get(i));
    }

    //transitions
    transitions.clear();
    ArrayList <Hitbox> thisTransition = thisZone.getTransitionZones(); 
    
    for(int i = 0; i < thisTransition.size(); i++){
      transitions.add(thisTransition.get(i));
    }

    //Enemies
  
    //Pickups
    pickups.clear();
    ArrayList <Pickup> thisPickup = thisZone.getPickups();
    for(int i = 0; i < thisPickup.size(); i++){
      pickups.add(thisPickup.get(i));
    }
    
    //chapterKeys = 0;
    //reqKeys = 1;

  }

}

  