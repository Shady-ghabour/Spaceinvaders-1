//Klasse for enemy lavet udfra Spaceship -
class Enemy extends SpaceShip {
  int HP = 1;
  boolean CoinDrop = false;
  boolean canShoot = true;
  int shootdelay = 0;
  boolean isBoss = false;
  int DamageIndicator = 1;
  int damageTakenIndicator = 1;
  boolean activeShot = false;
  boolean spawnNewWave = false;
  int RandomWaves = int(random(0, 5));
  int _xPos;
  int _yPos;


  //Enemy pixelart samt x og y positioner
  Enemy(int xpos, int ypos) {
    _xPos = xpos;
    _yPos = ypos;
    x = xpos;
    y = ypos;
    PixelRow    = new String[5];
    PixelRow[0] = "1011101";
    PixelRow[1] = "0101010";
    PixelRow[2] = "1111111";
    PixelRow[3] = "0101010";
    PixelRow[4] = "0000000";
  }
  // Opdaterer enemies position, både i x og y, udfra framecount
  void updateObj() {
    if (isBoss)
    {
      if (frameCount%30==0) {
        incy = false;
        x += direction * 4 * 7 + 5;
        if (x >= (width - (7 * pixelSize + pixelSize))) {
          direction = -1;
          incy=true;
        }
        if (x <= pixelSize) {
          direction = 1;
          incy = true;
        }
        if (canShoot) {
          Bullet bullet = new Bullet(x+ 3 * pixelSize, y + 5 * pixelSize + pixelSize);
          bullet.shootDownwards = true;
          bullets.add(bullet);
          canShoot = false;
          shootdelay = 0;
        }
        if (incy == true) {
          y += (4 * 7 + 5) / 2;
        }
      }
      //Giver skudene en delay som ovenfor
      shootdelay++;
      //Her inkluderes PowerUp systemmet, som 1/2 skudenes delay og spilleren skyder 2x hurtigere
    } else {
      if (frameCount%30==0) {
        x += direction * gridsize;
      }

      if (frameCount%10 == 0) {
        if (canShoot && activeShot) {

          Bullet bullet = new Bullet(x+ 3 * pixelSize, y + 5 * pixelSize);
          bullet.shootDownwards = true;
          bullets.add(bullet);
          canShoot = false;
          shootdelay = 0;
        }
      }

      if (incy == true) {
        y += gridsize / 2;
      }
    }
    if (shootdelay >=20) {
      canShoot = true;
    }
    shootdelay++;
  }


  //Scoresystem - Hvis bullets koordinater er de samme som enemy, fjerner den skudet, gør enemy rød og fjerner 1 liv fra enemy. Hvis life == 0, dør enemy og scoren stiger med 50
  boolean alive() {
    int offset = 5;

    if (HP <= 0) return false;

    for (int i = 0; i < bullets.size(); i++) {
      Bullet bullet = (Bullet) bullets.get(i);

      if ( (bullet.x > x) && (bullet.x < (x + 7 * pixelSize + offset)) && (bullet.y > y) && (bullet.y < (y + 5 * pixelSize))) {
        bullets.remove(i);

        HP = HP - damageTakenIndicator;

        nextColor = color(255, 0, 0);

       
        if (HP <= 0) {
          score += 50;

          if (HP<0) HP = 0;

          int Drops = int(random(0, 10));
          if (Drops == 0 || Drops == 1 && PowerUpRelease == false ) {

            PowerUpRelease = true;
            PowerUpx = x + 7 * pixelSize + offset;
            PowerUpy = y + 5 * pixelSize;
         
          }
          if (Drops >= 5 || Drops <= 10 && CoinDrop == false) {
            CoinDrop = true;
            _xPos = x + 7 * pixelSize + offset;
            _yPos = y + 5 * pixelSize;
          }
          return false;
        }

        break;
      }
    }


    return true;
  }


  boolean outside() {
    return x + (direction*gridsize) < 0 || x + (direction*gridsize) > width - gridsize;
  }

  boolean deathZone() {
    return y + gridsize > 500;
  }
}

void createEnemies(int damageTakenIndicator, int damageIndicator, int HP) {
  int gridsize  = 4 * 7 + 5;
  for (int i = 0; i < width/gridsize/2; i++) {
    int jMax = int(random(1, 4));  
    for (int j = 0; j <= jMax; j++) {
      Enemy enemy = new Enemy(i*gridsize, j*gridsize + 70);
      enemy.DamageIndicator = damageIndicator;
      enemy.damageTakenIndicator = damageTakenIndicator;
      enemy.isBoss = false;
      enemy.HP += HP;
      enemy.pixelSize = 4;
      enemy.objectColor = color(121, 27, 180);
      enemy.gridsize = enemy.pixelSize * 7 + 5;
      enemies.add(enemy);
    }
  }
}

void createBoss(int damageTakenIndicator, int damageIndicator, int HP) {
    // Create boss and give 100 HP
  if( boss == null) boss = new Enemy(10, 75);
  boss.isBoss = true;
  boss.HP += HP;
  boss.pixelSize = 35;
  boss.objectColor = color(255, 255, 0);  // yellow
  boss.gridsize = boss.pixelSize * 7 + 5;
  boss.DamageIndicator = damageIndicator;
  boss.damageTakenIndicator = damageTakenIndicator;
}
