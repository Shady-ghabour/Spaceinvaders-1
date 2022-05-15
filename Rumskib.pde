class SpaceShip {
  int x, y;
  int HP;
  String PixelRow[];
  color baseColor = color(255, 255, 255);
  color nextColor = baseColor;
  color objectColor = 0;
  int pixelSize = 4;
  int gridsize  = pixelSize * 7 + 5;

  void draw() {
    updateObj();
    drawPixelRow(x, y);
  }

  //Tegner pixels i hele spillet, både spilleren og enemies
  void drawPixelRow(int xpos, int ypos) {
    fill(objectColor);

    nextColor = baseColor;

    for (int i = 0; i < PixelRow.length; i++) {
      String row = (String) PixelRow[i];

      for (int j = 0; j < row.length(); j++) {
        if (row.charAt(j) == '1') {
          rect(xpos+(j * pixelSize), ypos+(i * pixelSize), pixelSize, pixelSize);
        }
      }
    }
  }

  void updateObj() {
  }
}

//Player klassen lavet ud fra Spaceship klasse
class Player extends SpaceShip {
  int DamageIndicator = 5;
  int damageTakenIndicator = 1;
  boolean canShoot = true;
  int shootdelay = 0;
  boolean player2Active = false;
  color PlayerColor = color(255);
  //Spillerens startposition
  Player() {
    x = pixelSize;
    y = height - (10 * pixelSize);
    //Rumskibets pixelart - 0 er sort 1 er hvid. Den er lavet med 5 rækker med en arraylist
    PixelRow    = new String[5];
    PixelRow[0] = "0001000";
    PixelRow[1] = "0001000";
    PixelRow[2] = "1011101";
    PixelRow[3] = "1111111";
    PixelRow[4] = "1011101";
    Playerx = x;
    Playery = y;
  }
  //Bevægelse højre og venstre
  void updateObj() {
    if (player2Active)
    {
      PlayerColor = color(255, 255, 0);
      if (keyPressed && (keyCode == 'A' || keyCode == 'a')) {
        x -= 5;
      }

      if (keyPressed && (keyCode == 'D' || keyCode == 'd')) {
        x += 5;
      }
      //Tjekker om v er trykket og om rumskibet kan skyde - Sørger for at spilleren ikke kan skyde med uendelig hastighed
      if (keyPressed && (keyCode == 'V' || keyCode == 'v') && canShoot) {
        bullets.add(new Bullet(x, y));
        canShoot = false;
        shootdelay = 0;
      }
    } else
    {
      if (keyPressed && keyCode == LEFT) {
        x -= 5;
      }

      if (keyPressed && keyCode == RIGHT) {
        x += 5;
      }
      //Tjekker om control er trykket og om rumskibet kan skyde - Sørger for at spilleren ikke kan skyde med uendelig hastighed
      if (keyPressed && keyCode == CONTROL && canShoot) {
        bullets.add(new Bullet(x, y));
        canShoot = false;
        shootdelay = 0;
      }
    }
    //Giver skudene en delay som ovenfor
    shootdelay++;
    //Her inkluderes PowerUp systemmet, som 1/2 skudenes delay og spilleren skyder 2x hurtigere
    if (shootdelay >=20 && PowerUpCollected == false) {
      canShoot = true;
    } else if (shootdelay >=10 && PowerUpCollected == true) {
      canShoot = true;
    }
  }

  boolean alivePlayer() {
    int offset = 5;

    if (EnduranceIndicator <= 0)  return false;


    for (int i = 0; i < bullets.size(); i++) {
      Bullet bullet = (Bullet) bullets.get(i);

      if ( (bullet.x > x) && (bullet.x < (x + 7 * pixelSize + offset)) && (bullet.y > y) && (bullet.y < (y + 5 * pixelSize))) {
        bullets.remove(i);

        HPBar = HPBar - damageTakenIndicator;
        EnduranceIndicator = EnduranceIndicator - damageTakenIndicator;

        nextColor = color(255, 0, 0);

        break;
      }
    }


    return true;
  }
}
