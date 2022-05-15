
//int pixelsize = 4;
//int gridsize  = pixelsize * 7 + 5;
Player player;
Player player2;
Enemy boss;
ArrayList enemies = new ArrayList();
ArrayList bullets = new ArrayList();
ArrayList coins = new ArrayList();
int direction = 1;
boolean incy = false;
int score = 0;
PFont f;
boolean PowerUpRelease = false;
boolean PowerUpCollected = false;
boolean CoinCollected = false;
boolean Play = false;
boolean Shop = false;
boolean isEnemy;
boolean Restart = true;
boolean PlayerSelect = false;
int HPBar = 200;
int EnduranceIndicator = 25;
int powerUpColor = color(27, 222, 60);
int PowerUpx;
int PowerUpy;
int TotalCoins = 250;
int Playerx;
int Playery;
int PowerUpTime = millis();
int PowerUpReleaseTimeStop = 0;
int EnemyHP = 1;
int EnemyDamageIndicator = 1;
int BossHP = 100;
int BossDamageIndicator = 1;
int nextLevelScore = 300;
PImage bg;
PImage gamebg;

void setup() {
  db = new SQLite(this, "mydatabase.sqlite");
  
  if(db.connect()){
  if(input.length()>0 && pwinput.length()>0){
    db.query(insert);
  }
  db.query(check);
  while(db.next()){
    isLogged = true;
  }
} 

  noStroke();
  size(800, 550);
  bg = loadImage("spaceinvadertest.jpg");
  gamebg = loadImage("Spaceinvadergamebg.jpg");
  background(bg);
  player = new Player();
  player.pixelSize = 4;
  player.objectColor = 255;
  player.gridsize = player.pixelSize * 7 + 5;

  player2 = new Player();
  player2.pixelSize = 4;
  player2.objectColor = 255;
  player2.gridsize = player.pixelSize * 7 + 5;

  EnemyDamageIndicator = 1;
  BossDamageIndicator = 1;

  createEnemies(player.DamageIndicator, EnemyDamageIndicator, 0);
  createBoss(player.DamageIndicator, BossDamageIndicator, 100);

  f = createFont("Arial", 36, true);
}

void draw() {
if(isLogged==true){
  if (Play == false && Shop == false) {
    background(bg);

    fill(255);
    textSize(20);
    text("Coins: " + String.valueOf(TotalCoins), width-100, 25);
    fill(175);

    rect(170, 325, 450, 200);
    fill(101, 92, 203);
    stroke(0);
    //Help Button
    ellipse(190, 350, 30, 30);
    fill(255, 255, 0);
    rect(187, 340, 6, 12);
    rect(187, 354, 6, 6);
    //Play Button
    fill(255);
    rect (190, 390, 200, 75);
    //Shop Button
    rect (400, 390, 200, 75);
    textSize(40);
    fill (0);
    text ("Play", 250, 265+175);
    text ("Shop", 450, 265+175);
    if (mouseX >=165 && mouseX <=205 && mouseY >= 335 && mouseY <= 365) {
      fill(255);
      rect(205, 270, 270, 75);
      fill(0);
      textSize(15);
      text("Velkommen til Space1nvaders", 210, 285);
      textSize(10);
      text("Dræb de mystiske aliens inden de når forbi dig og undvig", 210, 300);
      text("deres laserskud! Men pas på deres generaler!", 210, 310);
      text("de er nemlig også ude efter dig!", 210, 320);
      text("Spiller 1 bevæger sig med piltasterne <-   -> og skyder på CTRL", 210, 330);
      text("Spiller 2 bevæger sig med piltasterne a og d og skyder på v", 210, 340);
    }
    if (mousePressed) {
      if (mouseX >= 190 && mouseX <= 390 && mouseY >= 390 && mouseY <= 465) {
        Play = true;
        Shop = false;
      }
    }

    if (mousePressed) {
      if (mouseX >= 400 && mouseX <= 600 && mouseY >= 390 && mouseY <= 465) {
        Play = false;
        Shop = true;
      }
    }
  }
  
  /**************Shop*************/
  if (Shop == true && Play == false) {

    background(gamebg);
    //Help Button
    fill(101, 92, 203);
    ellipse(25, 25, 30, 30);
    fill(255, 255, 0);
    rect(22, 15, 6, 12);
    rect(22, 29, 6, 6);
    fill(255);
    if (mouseX >=10 && mouseX <=40 && mouseY >= 10 && mouseY <= 40) {
      rect(40, 20, 250, 60);
      textSize(10);
      fill(0);
      text("Ønsker du at blive stærkere, så er shoppen for dig!", 45, 35);
      text("For at skade mere kan du købe mere Damage ", 45, 45);
      text("For at overleve i længere til kan du købe mere endurance ", 45, 55);
      text("Hver opgradering koster 50 mønter ", 45, 65);
      text("Mønter skaffes ved at dræbe aliens ", 45, 75);
    }
    fill(255);
    rect(170, 150, 450, 210);
    stroke(0);
    textSize(30);
    text("Coins Left: "+String.valueOf(TotalCoins), 550, 530);

    //Mere skade
    rect (170, 150, 450, 75);
    rect (490, 167, 40, 40);
    fill(0);
    textSize(50);
    text("+", 498, 204);
    textSize(40);
    text ("Damage", 200, 200);
    text (String.valueOf(player.DamageIndicator), 550, 200);
    fill(255);
    if (mousePressed) {
      if (mouseX >= 490 && mouseX <= 530 && mouseY >= 167 && mouseY <= 207 && TotalCoins >= 50) {
        player.DamageIndicator = player.DamageIndicator + 1;
        TotalCoins = TotalCoins - 50;
      }
    }

    for (int i = 0; i < enemies.size(); i++) {
      Enemy enemy = (Enemy) enemies.get(i);
      enemy.damageTakenIndicator = player.DamageIndicator;
    }

    if (boss != null) boss.damageTakenIndicator = player.DamageIndicator;


    //Mere liv
    rect (170, 225, 450, 75);
    rect (490, 242, 40, 40);
    fill(0);
    textSize(50);
    text("+", 498, 279);
    textSize(40);
    text ("Endurance", 200, 275);
    text (String.valueOf(EnduranceIndicator), 550, 275);
    fill(255);
    if (mousePressed) {
      if (mouseX >= 490 && mouseX <= 530 && mouseY >= 242 && mouseY <= 282 && TotalCoins >= 50) {
        EnduranceIndicator = EnduranceIndicator + 1;
        TotalCoins = TotalCoins - 50;
      }
    }


    //Exit
    rect (170, 300, 450, 75);
    fill(0);
    text ("Exit", 200, 350);
    fill(255);
    if (mousePressed) {
      if (mouseX >= 170 && mouseX <= 620 && mouseY >= 300 && mouseY <= 375 && Shop == true) {
        Shop = false;
        Play = false;
      }
    }
  }

  if (Play == true && Shop == false && Restart == true && PlayerSelect == false) {
    background(gamebg);
    fill(255);
    //Player 1
    rect (170, 150, 450, 75);
    fill(0);

    textSize(40);
    text ("1 Player", 200, 200);
    fill(255);
    if (mousePressed) {
      if (mouseX >= 170 && mouseX <= 620 && mouseY >= 150 && mouseY <= 225) {
        PlayerSelect = true;
      }
    }
    //Player 2
    rect (170, 225, 450, 75);
    fill(0);
    textSize(40);
    text ("2 Player", 200, 275);
    fill(255);
    if (mousePressed) {
      if (mouseX >= 170 && mouseX <= 620 && mouseY >= 225 && mouseY <= 300) {
        PlayerSelect = true;
        player2.player2Active = true;
      }
    }
  }

  if (Play == true && Shop == false && Restart == true && PlayerSelect == true) {
    stroke(0);
    background(gamebg);
    fill(255);
    drawScore();
    fill(255);
    textSize(20);
    fill(7, 232, 31);
    rect(10, 20, HPBar, 25);
    fill(255);
    text("HP Left: "+String.valueOf(EnduranceIndicator), 20, 40);
    noStroke();
    DEATHZONE();
    if (player.alivePlayer()) {
      player.PlayerColor = color(255, 255, 3);
      player.draw();
    }

    if (player2.alivePlayer()) {
      player2.draw();
    }


    for (int i = 0; i < bullets.size(); i++) {
      Bullet bullet = (Bullet) bullets.get(i);
      bullet.pixelSize = 4;
      bullet.draw();
    }


    for (int i = 0; i < enemies.size(); i++) {
      Enemy enemy = (Enemy) enemies.get(i);
      if (enemy.outside() == true) {
        direction *= (-1);
        incy = true;
        break;
      }
    }

    int Shooter = int(random(0, enemies.size()));
    for (int i = 0; i < enemies.size(); i++) {
      Enemy enemy = (Enemy) enemies.get(i);
      if (!enemy.alive()) {
        if (enemy.CoinDrop == true)
        {
          Coin coin = new Coin(enemy._xPos, enemy._yPos);
          coins.add(coin);
        }
        enemies.remove(i);
        if (enemies.size() == 0) createBoss(player.DamageIndicator, BossDamageIndicator, BossHP);
      } else {
        if (i == Shooter && (enemy._yPos == ((Enemy) enemies.get(enemies.size()-1))._yPos) ) {
          enemy.activeShot = true;
        } else
        {
          enemy.activeShot = false;
        }
        enemy.draw();
      }
    }

    if (enemies.size() == 0) {
      if (boss.alive()) {
        boss.draw();
        player.damageTakenIndicator =  boss.DamageIndicator;
        BossDamageIndicator = boss.DamageIndicator;
        BossHP = boss.HP;
      } else {
        createEnemies(player.DamageIndicator, EnemyDamageIndicator, EnemyHP);
      }
    }

    /* Coins handling */
    for (int i = 0; i < coins.size(); i++) {
      Coin coin = (Coin) coins.get(i);

      if ((coin._x >= player.x) && (coin._x <= player.x+25) && (coin._y == player.y ))
      {
        TotalCoins = TotalCoins + 25;
        coin.drawCoin = false;
        coins.remove(i);
      }
      coin.draw();
    }


    incy = false;


    /*******************PowerUpSystem********************/
    if (PowerUpRelease == true) {
      powerUp(PowerUpx, PowerUpy);
      PowerUpy++;
      if (PowerUpy >= height) {
        PowerUpRelease = false;
      }
      if ((PowerUpx >= player.x -10 ) && (PowerUpx <= player.x + 10)&& (PowerUpy >= Playery ))
      {
        PowerUpCollected = true;
        PowerUpRelease = false;
        PowerUpx = 0;
        PowerUpy = 0;
        PowerUpReleaseTimeStop = millis()+10*1000;
      }
    }
    if ((PowerUpCollected == true) && (millis() >= PowerUpReleaseTimeStop)) {
      PowerUpCollected = false;
    }

    /***********************************************************************************************************************************************************************************/
    for (int i = 0; i < enemies.size(); i++) {
      Enemy enemy = (Enemy) enemies.get(i);
      textSize(9);
      fill(enemy.objectColor);
      text("Enemy("+i+") HP: " + String.valueOf(enemy.HP), 20, 60+(i*10));
    }
    if (enemies.size() == 0)
    {
      textSize(9);
      fill(boss.objectColor);
      text("Boss HP: " + boss.HP, 20, 60);
      /* Debug info 
      text("Boss.DamageIndicator: " + boss.DamageIndicator, 20, 70);
      text("Boss.damageTakenIndicator: " + boss.damageTakenIndicator, 20, 80);
      */
    }

    if (score == nextLevelScore) {
      for (int i = 0; i < enemies.size(); i++) {
        Enemy enemy = (Enemy) enemies.get(i);
        enemy.HP += 3;
        enemy.DamageIndicator += 2;
      }
      boss.DamageIndicator += 5;
      BossDamageIndicator = boss.DamageIndicator; 
      nextLevelScore += 300;
    }

    if (enemies.size() > 0)
    {
      player.damageTakenIndicator =  ((Enemy) enemies.get(0)).DamageIndicator;
      EnemyHP = ((Enemy) enemies.get(0)).HP;
      EnemyDamageIndicator = ((Enemy) enemies.get(0)).DamageIndicator;
    }
  }


  /* Player is dead */
  if (player.alivePlayer()==false) {
    fill(0);
    rect(0, 0, 800, 550);
    Restart = false;

    fill(255);
    textSize(50);
    text("You Died!", width/2-120, height/2);
    text("Press R to try again", width/2-225, height/2+100);
    if (keyPressed && keyCode == 'r' || keyCode == 'R') {

      //Resets Enemies
      for (int i = enemies.size()-1; i>0; i--) {
        enemies.remove(i);
      }
      //Resets Coins
      for (int i = coins.size()-1; i>0; i--) {
        coins.remove(i);
      }
      //Resets Bullets
      for (int i = bullets.size()-1; i>0; i--) {
        bullets.remove(i);
      }
      //Resets PowerUp
      PowerUpx = -100;
      PowerUpy = -100;

      Shop = false;
      Play = false;
      EnduranceIndicator = 25 + EnduranceIndicator;
      Restart = true;
      BossHP = 100;
      EnemyHP = 1;
      player.damageTakenIndicator = 1;
      EnemyDamageIndicator = 1;
      BossDamageIndicator = 1;
      createEnemies(player.DamageIndicator, player.damageTakenIndicator, 0);
      createBoss(player.DamageIndicator, player.damageTakenIndicator, 100);
      nextLevelScore = 300;
      score = 0;
    }
  }
}
if(isLogged==false){
exit();
}
}
/***********************************************************************************************************************************************************************************/
/**************************************/
