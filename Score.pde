  /*******************Scoreboard********************/
  
void drawScore() {

  textFont(f);
  text("Score: " + String.valueOf(score), 300, 50);
  textSize(20);
  text("Coins: " + String.valueOf(TotalCoins), width-110, 25);
}
