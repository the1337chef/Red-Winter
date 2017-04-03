  
void loadZone(){
  if(nextZone == "null"){
    println("ERROR: nextZone == NULL");
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
    
    //chapterKeys = 0;
    //reqKeys = 1;

  }

}

  