class C2048
{
  private int[][][] array;
  private int sizeX;
  private int sizeY;
  private int frameSizeX;
  private int frameSizeY;
  private int score=0;
  private float textSize=5.0;
  private float screenSizeRatio=0.0;
  private boolean gameOver=false;
  
  C2048(int sizeX, int sizeY,int frameSizeX, int frameSizeY)
  {
    this.sizeX=sizeX;
    this.sizeY=sizeY;
    this.frameSizeX=frameSizeX;
    this.frameSizeY=frameSizeY;
    this.screenSizeRatio= this.frameSizeX/this.sizeX <= this.frameSizeY/this.sizeY ? this.frameSizeX/this.sizeX : this.frameSizeY/this.sizeY;
    this.textSize=this.screenSizeRatio*0.45;
    this.array= new int[2][this.sizeY][this.sizeX];
    addBlock();
    addBlock();
  }
  
  private void addBlock() //geht das spielfeld durch solange bis eine leere stelle ist um eine neue zahl einzufügen
  {
    PVector randpos= new PVector();
    do{
        randpos.x=int(random(0,sizeX));
        randpos.y=int(random(0,sizeY));
      }
    while(this.array[0][int(randpos.y)][int(randpos.x)]>0);
    this.array[0][int(randpos.y)][int(randpos.x)]=random(0,100)>10?2:4;
  }
  
  private boolean spaceLeft() //geht das spielfeld durch bis eine leere stelle gefunden wurde und returned entsprechend
  {
    for(int y=0; y<this.sizeY; y++)
    {
      for(int x=0; x<this.sizeX; x++)
      {
        if(this.array[0][y][x]==0) return true;
      }
    }
    return false;
  }
  
  private boolean equal() //geht das spielfeld durch bis die stelle im aktuellen und vorherigen spielfeld nicht mehr gleich sind und returned entsprechend
  {
    for(int y=0; y<this.sizeY; y++)
    {
      for(int x=0; x<this.sizeX; x++)
      {
        if(this.array[1][y][x]!=this.array[0][y][x]) return false;
      }
    }
    return true;
  }
  
  public boolean getGameOver() //gibt den status des spiels zurück
  {
    return this.gameOver;
  }
  
  public int getScore() //gibt den score des spiels zurück
  {
    return this.score;
  }
  
  private boolean checkGameOver() //überprüft ob noch züge möglich sind
  {
    
    for(int d=0; d<4; d++)
    {
      copyArray();
      processMove(d,this.array[1],false);
      if(!equal())return false;
    }
    return true;
  }
  
  private void copyArray() //kopiert den inhalt das aktuellen felds in das vorherige
  {
    for(int y=0; y<this.sizeY; y++)
    {
      for(int x=0; x<this.sizeX; x++)
      {
        this.array[1][y][x]=this.array[0][y][x];
      }
    }
  }
  
  private void processMove(int direction, int[][] arr, boolean scoreMove) //verarbeitet richtungsabhängig einen zug für ein feld mit optionaler punkte vergabe
  {
    int index=0;
    int lastval=0;
    switch(direction)
    {
      case 0: //right
        for(int y=0; y<this.sizeY; y++)
        {
          index=this.sizeX-1;
          lastval=arr[y][this.sizeX-1];
          for(int x=this.sizeX-2; x>=0; x--)
          {
            if(lastval<=0)
            {
              lastval=arr[y][x];
            }
            else if(lastval==arr[y][x])
            {
              arr[y][index]=lastval*2;
              arr[y][x]=0;
              if(scoreMove)this.score+=lastval*2;
              index--;
              lastval=0;
            }
            else if(arr[y][x]>0)
            {
              arr[y][index]=lastval;
              index--;
              lastval=arr[y][x];
            }
            else if(x==0)
            {
              arr[y][index]=lastval;
              index--;
            }
          }
          arr[y][index]=arr[y][0];
          index--;
          while(index>=0)
          {
            arr[y][index]=0;
            index--;
          }
        }
        break;
      case 1: //down
        for(int x=0; x<this.sizeX; x++)
        {
          index=this.sizeY-1;
          lastval=arr[this.sizeY-1][x];
          for(int y=this.sizeY-2; y>=0; y--)
          {
            if(lastval<=0)
            {
              lastval=arr[y][x];
            }
            else if(lastval==arr[y][x])
            {
              arr[index][x]=lastval*2;
              arr[y][x]=0;
              if(scoreMove)this.score+=lastval*2;
              index--;
              lastval=0;
            }
            else if(arr[y][x]>0)
            {
              arr[index][x]=lastval;
              index--;
              lastval=arr[y][x];
            }
            else if(y==0)
            {
              arr[index][x]=lastval;
              index--;
            }
          }
          arr[index][x]=arr[0][x];
          index--;
          while(index>=0)
          {
            arr[index][x]=0;
            index--;
          }
        }
        break;
      case 2: //left
        for(int y=0; y<this.sizeY; y++)
        {
          index=0;
          lastval=arr[y][0];
          for(int x=1; x<this.sizeX; x++)
          {
            if(lastval<=0)
            {
              lastval=arr[y][x];
            }
            else if(lastval==arr[y][x])
            {
              arr[y][index]=lastval*2;
              arr[y][x]=0;
              if(scoreMove)this.score+=lastval*2;
              index++;
              lastval=0;
            }
            else if(arr[y][x]>0)
            {
              arr[y][index]=lastval;
              index++;
              lastval=arr[y][x];
            }
            else if(x==this.sizeX-1)
            {
              arr[y][index]=lastval;
              index++;
            }
          }
          arr[y][index]=arr[y][this.sizeX-1];
          index++;
          while(index<this.sizeX)
          {
            arr[y][index]=0;
            index++;
          }
        }
        break;
      case 3: //up
        for(int x=0; x<this.sizeX; x++)
        {
          index=0;
          lastval=arr[0][x];
          for(int y=1; y<this.sizeY; y++)
          {
            if(lastval<=0)
            {
              lastval=arr[y][x];
            }
            else if(lastval==arr[y][x])
            {
              arr[index][x]=lastval*2;
              arr[y][x]=0;
              if(scoreMove)this.score+=lastval*2;
              index++;
              lastval=0;
            }
            else if(arr[y][x]>0)
            {
              arr[index][x]=lastval;
              index++;
              lastval=arr[y][x];
            }
            else if(y==this.sizeY-1)
            {
              arr[index][x]=lastval;
              index++;
            }
          }
          arr[index][x]=arr[this.sizeY-1][x];
          index++;
          while(index<this.sizeY)
          {
            arr[index][x]=0;
            index++;
          }
        }
        break;
    }
  }
  
  public void update(int direction) //nimmt zug richtung entgegen und sorgt für die verarbeitung von diesem
  {
    copyArray();
    
    processMove(direction,this.array[0], true);
    
    if(!equal()) addBlock();
    if(!spaceLeft())
    {
      this.gameOver=checkGameOver();
      if(this.gameOver)return;
    }
  }
  
  public void draw() //zeichnet raster, zahlen und den aktuellen score
  {
    noStroke();
    fill(0);
    rect(0,0,frameSizeX,frameSizeY);
    
    strokeWeight(1);
    stroke(175);
    textSize(50);
    textAlign(CENTER);
    
    for(int x=1; x<this.sizeX; x++)
    {
      line(frameSizeX/float(this.sizeX)*x,0,frameSizeX/float(this.sizeX)*x,frameSizeY);
    }
    for(int y=1; y<this.sizeY; y++)
    {
      line(0,frameSizeY/float(this.sizeY)*y,frameSizeX,frameSizeY/float(this.sizeY)*y);
    }
    
    colorMode(HSB, 12, 100, 100);
    textSize(textSize);
    for(int y=0; y<this.sizeY; y++)
    {
      for(int x=0; x<this.sizeX; x++)
      {
        if(this.array[0][y][x]>0)
        {
          fill(log(float(this.array[0][y][x])) / log(2.0),100,80);
          text(this.array[0][y][x],frameSizeX/float(this.sizeX)*x+frameSizeX/(2.0*this.sizeX),frameSizeY/float(this.sizeY)*y+frameSizeX/(2.0*this.sizeY)+this.screenSizeRatio*0.15);
        }
      }
    }
    
    colorMode(RGB, 255, 255, 255);
    
    noStroke();
    fill(80);
    rect(0,frameSizeY,frameSizeX,50);
    fill(175);
    textSize(40);
    textAlign(LEFT);
    text(score,130,height-10);
  }
}
