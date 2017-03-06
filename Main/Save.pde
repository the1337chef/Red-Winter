//Save

//Can be prompted by user in the menu or a checkpoint

public void save(){
//TODO: Make sure all the values are updated before you save
//TODO: have a save icon show up
saveWriter = createWriter("data/save.txt");
saveWriter.println("zone=" + currentZone);
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

void printSave(boolean saved){
  if((millis()- currentTime) > 5000){ //Wait 5 seconds to do away with the Saved Successfully print
    saved = false;
    saveCompleted = false;
  }
  
  
  if(saved == true){
    println("Printing Save!");
    textSize(20);
    //textAlign(CENTER,CENTER);
    text("Saved Successfully", 6*width/7, height/5);
  }
}