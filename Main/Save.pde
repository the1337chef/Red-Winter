//Save

//Can be prompted by user in the menu or a checkpoint

public void save(){
//TODO: Make sure all the values are updated before you save
saveWriter = createWriter("data/save.txt");
saveWriter.println("chapter=" + currentChapter);
saveWriter.println("zone=" + currentZone);
saveWriter.println("xpos=" + nextPlayerX);
saveWriter.println("ypos=" + nextPlayerY);
saveWriter.println("health=" + saveHealth);
saveWriter.println("stamina=" + saveStamina);
saveWriter.println("temp=" + saveTemp);
saveWriter.println("ammo=" + saveAmmo);
saveWriter.println("last_cutscene=" + last_cutscene);
saveWriter.println("dynamite=" + dynamite);
saveWriter.println("detonator=" + detonator);
saveWriter.println("rope=" + rope);
saveWriter.println("collar=" + collar);
saveWriter.println("seal1=" + seal1);
saveWriter.println("seal2=" + seal2);
saveWriter.println("whale=" + whale);
saveWriter.println("sap=" + sap);
saveWriter.flush();
saveWriter.close();
//println("Save completed");
saveCompleted = true;
currentTime = millis();
}

void printSave(boolean saved){
  if((millis()- currentTime) > 5000){ //Wait 5 seconds to do away with the Saved Successfully print
    saved = false;
    saveCompleted = false;
  }
  
  
  if(saved == true){
    pushMatrix();
    noStroke();
    rectMode(CENTER);
    textSize(20);
    fill(0,80);
    rect(width-115,0,350,100);
    fill(255);
    text("Saved Successfully", width-145, 25);
    popMatrix();
  }
}

public void newSave(){
//Reset values
currentChapter = "1";
currentZone = "1";
nextPlayerX = 96;
nextPlayerY = 480;
saveHealth = 100;
saveTemp = 100;
saveAmmo = 0;
last_cutscene = "0";
dynamite = 0;
detonator = 0;
rope = 0;
collar = 0;
seal1 = 0;
seal2 = 0;
whale = 0;
sap = 0;

nextZone = "1";
println("nextZone is 1 form newsave");
nextZoneChanged = false;
//println("nzf2");

saveWriter = createWriter("data/save.txt");
saveWriter.println("chapter=" + currentChapter);
saveWriter.println("zone=" + currentZone);
saveWriter.println("xpos=" + nextPlayerX);
saveWriter.println("ypos=" + nextPlayerY);
saveWriter.println("health=" + saveHealth);
saveWriter.println("stamina=" + saveStamina);
saveWriter.println("temp=" + saveTemp);
saveWriter.println("ammo=" + saveAmmo);
saveWriter.println("last_cutscene=" + last_cutscene);
saveWriter.println("dynamite=" + dynamite);
saveWriter.println("detonator=" + detonator);
saveWriter.println("rope=" + rope);
saveWriter.println("collar=" + collar);
saveWriter.println("seal1=" + seal1);
saveWriter.println("seal2=" + seal2);
saveWriter.println("whale=" + whale);
saveWriter.println("sap=" + sap);
saveWriter.flush();
saveWriter.close();
println("Save completed");
saveCompleted = true;
currentTime = millis();
}