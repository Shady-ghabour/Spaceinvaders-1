class Coin {
  boolean drawCoin = true;
  int _x;
  int _y;

  Coin( int x, int y )
  {
    _x = x;
    _y = y;
  }

  void draw() {
    if (drawCoin)
    {
      fill(255, 230, 3);
      circle(_x, _y, 25);
      textSize(15);
      fill(0);
      text("$", _x-4, _y+5);
      _y++;
    }
  }
}
