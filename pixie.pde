class Pixie
{
  Pixie[] neighbours = new Pixie[8];
  PVector pos = new PVector();
  int size = 1;
  
  boolean currentState = false;
  boolean futureState = false;
  
  Pixie(int x, int y, int size){
    pos.x = x;
    pos.y = y;
    this.size = size;
  }
  
  void setState(boolean state){
    currentState = state;
    futureState = state;
  }
  
  void setNeighbours(Pixie[] n){
    neighbours = n; //<>//
  }
  
  void prepare(){
    int neighbourCount = 0;
    for(int i=0; i<neighbours.length; i++){
      if(neighbours[i].currentState){
        neighbourCount++;
      }
    }
    
    if(currentState == true){
      if(neighbourCount > 1 && neighbourCount < 4){
        futureState = true;
      }
      else {
        futureState = false;
      }
    }
    else{
      if(neighbourCount > 2 && neighbourCount < 4){
        futureState = true;
      }
      else {
        futureState = false;
      }
    }
  }
  
  void update(){
    currentState = futureState;
  }
  
  void draw(){
    if(currentState == true){
      fill(0);
      rect(pos.x, pos.y, size, size);
    }
  }
}