Pixie[][] pixies;
int pixiesize = 5;
boolean paused = true;

void setup(){
  size(640,480);
  frameRate(60);
  textFont(loadFont("Monospaced-14.vlw"));
  int w = int(width/pixiesize);
  int h = int(height/pixiesize);
  
  pixies = new Pixie[h-20][w];
  
  // Create pixies
  for(int y=0; y<pixies.length; y++){
    for(int x=0; x<pixies[y].length; x++){
      pixies[y][x] = new Pixie(x*pixiesize, y*pixiesize, pixiesize);
    }
  }
  
  // Set Neighbours for pixies
  for(int y=0; y<pixies.length; y++){
    for(int x=0; x<pixies[y].length; x++){
      pixies[y][x].setNeighbours(getNeighbours(x,y));
    }
  }
  
  //for(int i=0; i<2000; i++){
  //  pixies[int(random(pixies.length))][int(random(pixies[0].length))].setState(true);
  //}
}

Pixie[] getNeighbours(int x, int y){
  Pixie[] neighbours = new Pixie[8];
  int i=0;
  
  for(int a=-1; a<=1; a++){
    for(int b=-1; b<=1; b++){
      if(a==0 && b==0){
        continue;
      }
      
      int xOffset = 0;
      int yOffset = 0;
      
      if(y+a < 0){
        yOffset = a + pixies.length;
      }
      else if(y+a > pixies.length-1){
        yOffset = a - pixies.length;
      }
      else {
        yOffset = a;
      }
      
      if(x+b < 0){
        xOffset = b + pixies[y].length;
      }
      else if(x+b > pixies[y].length-1){
        xOffset = b - pixies[y].length;
      }
      else {
        xOffset = b;
      }
      
      neighbours[i] = pixies[y+yOffset][x+xOffset];
      i++;
    }
  }
  
  return neighbours;
}

void draw(){
  background(255);
  
  if(!paused){
    for(int y=0; y<pixies.length; y++){
      for(int x=0; x<pixies[y].length; x++){
        pixies[y][x].prepare();
      }
    }
  }
  
  for(int y=0; y<pixies.length; y++){
    for(int x=0; x<pixies[y].length; x++){
      if(!paused){
        pixies[y][x].update();
      }
      pixies[y][x].draw();
    }
  }
  
  if(mousePressed){
    int mx = int(mouseX/pixiesize);
    int my = int(mouseY/pixiesize);
    if(mouseButton == LEFT){
      if(my > 0 && my < pixies.length && mx > 0 && mx < pixies[0].length){
        pixies[my][mx].setState(true);
      }
    }
    else{
      if(my > 0 && my < pixies.length && mx > 0 && mx < pixies[0].length){
        pixies[my][mx].setState(false);
      }
    }
  }
  
  fill(0);
  textAlign(CENTER, CENTER);
  if(paused){
    text("Press SPACE to play", width/2, height-10); 
  }
  else{
    text("Press SPACE to pause", width/2, height-10);
  }
}

void reset(){
  for(int y=0; y<pixies.length; y++){
    for(int x=0; x<pixies[y].length; x++){
      pixies[y][x].setState(false);
    }
  }
}

void keyPressed(){
  if(keyCode == 32){
    paused = !paused;
    
    if(paused){
      frameRate(60);
    }
    else{
      frameRate(8);
    }
  }
  
  if(keyCode == 82){
    reset();
  }
}