class Bullet {
    int x, y;
    int pixelSize = 4;
    int gridsize  = pixelSize * 7 + 5;
    boolean shootDownwards = false;

    Bullet(int xpos, int ypos) {
        x = xpos + gridsize/2 - 4;
        y = ypos;
    }

    void draw() {
        fill(255);
        if (PowerUpCollected == true && !shootDownwards){
         fill(powerUpColor); 
        }
        rect(x, y, pixelSize, pixelSize);
        
        if(!shootDownwards){
          y -= pixelSize * 2;
         
        }
          
        else
          y += pixelSize * 2;
          
          
    }
}
