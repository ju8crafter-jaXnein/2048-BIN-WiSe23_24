C2048 spiel;
Menu m;
HighscoreHandler h;
boolean mouseClicked=false;
boolean inMenu=true;

void setup()
{
  size(800,850);
  frameRate(30);
  h=new HighscoreHandler();
  m = new Menu(h);
  background(0);
}

void draw()
{
  if(inMenu)
  {
    if(m.update(mouseClicked))
    {
      spiel= new C2048(m.getX(),m.getY(),800,800);
      inMenu=false;
      spiel.draw();
    }
    m.draw();
  }
  else
  {
    if(spiel.getGameOver())
    {
      m.setGameOver();
      h.setHighscore(m.getX()+"x"+m.getY(),spiel.getScore());
      inMenu=true;
    }
  }
  mouseClicked=false;
}

void keyPressed()
{
  if(key == CODED && !inMenu)
  {
    switch(keyCode)
    {
      case RIGHT:
        spiel.update(0);
         break;
      case DOWN:
        spiel.update(1);
        break;
      case LEFT:
        spiel.update(2);
        break;
      case UP:
        spiel.update(3);
        break;
     
      default:
        return;
    }
  
    spiel.draw();
    m.draw();
  }
}

void mouseClicked()
{
  mouseClicked=true;
}
