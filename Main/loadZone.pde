  
void loadZone(){
  switch(nextZone){
    case "1":
      testZone();
      break;
    case "2":
      testZone2();
      break;
    default:
      println("ERROR: nextZone == NULL");
      break;
  }
}