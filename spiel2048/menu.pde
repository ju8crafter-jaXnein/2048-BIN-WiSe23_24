class Menu
{
  private HighscoreHandler hsh;
  private boolean playButtonHover=false;
  private boolean leftPlusButtonHover=false;
  private boolean rightPlusButtonHover=false;
  private boolean leftMinusButtonHover=false;
  private boolean rightMinusButtonHover=false;
  private boolean infoButtonHover=false;
  private int menuState=0;
  private String currentHighscore="";
  private int x=4;
  private int y=4;
  private color[] c={color(175),color(75)};
  
  Menu(HighscoreHandler hsh)
  {
    this.hsh=hsh;
  }
  
  public boolean update(boolean mouseClicked) //verarbeitet menü eingaben und gibt zurück ob ein spiel gestartet wird
  {
    switch(menuState)
    {
      case 0://mainmenu
        this.playButtonHover=mouseX>=width/2-100&&mouseX<=width/2+100&&mouseY>=height/2+20&&mouseY<=height/2+60;
        this.leftPlusButtonHover=mouseX>=width/2-100&&mouseX<=width/2-40&&mouseY>=height/2+70&&mouseY<=height/2+95;
        this.rightPlusButtonHover=mouseX>=width/2+40&&mouseX<=width/2+100&&mouseY>=height/2+70&&mouseY<=height/2+95;
        this.leftMinusButtonHover=mouseX>=width/2-100&&mouseX<=width/2-40&&mouseY>=height/2+150&&mouseY<=height/2+175;
        this.rightMinusButtonHover=mouseX>=width/2+40&&mouseX<=width/2+100&&mouseY>=height/2+150&&mouseY<=height/2+175;
        this.infoButtonHover=mouseX>=width-50&&mouseX<=width-10&&mouseY>=height-50&&mouseY<=height-10;
        if(mouseClicked&&!this.infoButtonHover)
        {
          if(this.playButtonHover)
          {
            this.menuState=1;
            currentHighscore=hsh.getHighscore(this.x+"x"+this.y);
            return true;
          }
          else if(this.leftPlusButtonHover&&this.x<16)this.x++;
          else if(this.rightPlusButtonHover&&this.y<16)this.y++;
          else if(this.leftMinusButtonHover&&this.x>3)this.x--;
          else if(this.rightMinusButtonHover&&this.y>3)this.y--;
        }
        break;
      case 2://gameover
        if(mouseClicked)this.menuState=0;
      case 3://highscorelist
        break;

  }
    return false;
  }
  
  public void draw() //zeichnet das menü dem aktuellen kontext entsprechend
  {
    switch(menuState)
    {
      case 0://mainmenu
        background(0);
        if(!infoButtonHover)
        {
          textAlign(CENTER);
          textSize(100);
          fill(175);
          text("2048", width/2, height/2);
          
          noFill();
          strokeWeight(3);
          stroke(this.c[int(this.playButtonHover)]);
          rect(width/2-100, height/2+20,200,40);
          textSize(25);
          fill(c[int(this.playButtonHover)]);
          text("PLAY",width/2, height/2+50);
          
          noFill();
          stroke(this.c[1]);
          rect(width/2-100, height/2+98,60,49);
          rect(width/2+40, height/2+98,60,49);
          
          line(width/2-20, height/2+125-20, width/2+20, height/2+125+20);
          line(width/2+20, height/2+125-20, width/2-20, height/2+125+20);
          
          
          stroke(this.c[int(this.leftPlusButtonHover)]);
          rect(width/2-100, height/2+70,60,25);
          line(width/2-90, height/2+88,width/2-70, height/2+79);
          line(width/2-50, height/2+88,width/2-70, height/2+79);
          
          stroke(this.c[int(this.rightPlusButtonHover)]);
          rect(width/2+40, height/2+70,60,25);
          line(width/2+50, height/2+88,width/2+70, height/2+79);
          line(width/2+90, height/2+88,width/2+70, height/2+79);
          
          stroke(this.c[int(this.leftMinusButtonHover)]);
          rect(width/2-100, height/2+150,60,25);
          line(width/2-90, height/2+157,width/2-70, height/2+166);
          line(width/2-50, height/2+157,width/2-70, height/2+166);
          
          stroke(this.c[int(this.rightMinusButtonHover)]);
          rect(width/2+40, height/2+150,60,25);
          line(width/2+50, height/2+157,width/2+70, height/2+166);
          line(width/2+90, height/2+157,width/2+70, height/2+166);
          
          fill(this.c[1]);
          text(this.y,width/2+70,height/2+130);
          text(this.x,width/2-70,height/2+130);
        }
        else
        {
          noStroke();
          fill(c[1]);
          rect(100, 100, width-200, height-200);
          fill(c[0]);
          textSize(20);
          textAlign(LEFT);
          text("2048 Spielanleitung:", 170, 130);
          text("1. Ziel des Spiels:", 170, 160);
          text("   Kombiniere die Zahlen, um die Zahl 2048 zu erreichen.", 170, 190);
          text("2. Steuerung:", 170, 230);
          text("   Verwende die Pfeiltasten:", 170, 260);
          text("   - Nach oben: Bewege die Zahlen nach oben", 170, 290);
          text("   - Nach unten: Bewege die Zahlen nach unten", 170, 320);
          text("   - Nach links: Bewege die Zahlen nach links", 170, 350);
          text("   - Nach rechts: Bewege die Zahlen nach rechts", 170, 380);
        }
        
        noFill();
        stroke(this.c[int(this.infoButtonHover)]);
        rect(width-50,height-50,40,40);
        fill(this.c[int(this.infoButtonHover)]);
        textSize(30);
        text("i",width-30,height-20);
        
        break;
      case 1:
        fill(c[0]);
        textSize(40);
        textAlign(LEFT);
        text("Score: ",10,height-10);
        text("Highscore: "+this.currentHighscore,width/2-40,height-10);
        break;
      case 2://gameover
        textAlign(CENTER);
        textSize(100);
        fill(175,0,0);
        text("Game Over", width/2, height/2);
        textSize(25);
        fill(75,0,0);
        text("Click to return to Menu", width/2, height/2+40);
        break;
      case 3://highscorelist
        break;

    }
  }
  
  public int getX() //gibt den wert des linken zahl einstell feld zurück
  {
    return this.x;
  }
  
  public int getY() //gibt den wert des rechten zahl einstell feld zurück
  {
    return this.y;
  }
  
  public void setGameOver() //stellt das menü auf gameover
  {
    this.menuState=2;
  }
}
