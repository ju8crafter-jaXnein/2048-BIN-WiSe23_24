class HighscoreHandler
{
  private String[] highscores;
  
  HighscoreHandler()
  {
    highscores=loadStrings("highscores.txt");
    if(highscores==null)highscores= new String[0];
  }
  
  public String getHighscore(String val) //schaut die liste durch und gibt den highscore von der gegebenen spielfeld größe zurück
  {
    for(int i=0; i<highscores.length; i+=2)if(highscores[i].equals(val))return highscores[i+1];
    return "0";
  }
  
  public void setHighscore(String val, int score) //überprüft ob der bekommene score ein highscore für die gegebene feldgröße ist und speichert  
  {
    for(int i=0; i<highscores.length; i+=2)
    {
      if(highscores[i].equals(val))
      {
        if(score>int(highscores[i+1]))highscores[i+1]=str(score);
        saveStrings("highscores.txt",highscores);
        return;
      }
    }
    highscores=append(highscores,val);
    highscores=append(highscores,str(score));
    saveStrings("highscores.txt",highscores);
  }
}
