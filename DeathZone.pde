void DEATHZONE(){
  fill(255, 0, 0);
    rect(0, 500, 800, 5);
  for (int i = 0; i < enemies.size(); i++) {
      Enemy enemy = (Enemy) enemies.get(i);
      if (enemy.deathZone() == true) {
        EnduranceIndicator = 0;
        break;
      }
    }
}
  
