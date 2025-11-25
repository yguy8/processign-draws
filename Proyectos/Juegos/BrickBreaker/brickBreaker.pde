// Breakout con pantalla de fin de juego y botones

Ball ball;
Paddle paddle;
ArrayList<Block> blocks;
int score = 0;
boolean gameOver = false;

void setup() {
  size(600, 400);
  startGame();
}

void draw() {
  background(0);
  
  if (!gameOver) {
    // Mostrar y mover pelota
    ball.update();
    ball.show();
    
    // Mostrar paleta
    paddle.show();
    
    // Colisión con paleta
    ball.checkPaddle(paddle);
    
    // Colisión con bloques
    for (int i = blocks.size()-1; i >= 0; i--) {
      Block b = blocks.get(i);
      if (ball.checkBlock(b)) {
        blocks.remove(i);
        score += 10;
      } else {
        b.show();
      }
    }
    
    // Mostrar puntuación en negro arriba a la izquierda
    fill(0);              // ← color negro
    textSize(16);
    textAlign(LEFT, TOP);
    text("Puntos: " + score, 10, 10);
    
    // Fin del juego
    if (ball.y > height) {
      gameOver = true;
    }
    
  } else {
    // Pantalla de fin de juego
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(32);
    text("Fin del juego", width/2, height/3);
    
    // Botón volver a intentar
    fill(0, 200, 0);
    rect(width/2 - 100, height/2, 80, 40);
    fill(255);
    textSize(16);
    text("Reintentar", width/2 - 60, height/2 + 20);
    
    // Botón salir
    fill(200, 0, 0);
    rect(width/2 + 20, height/2, 80, 40);
    fill(255);
    text("Salir", width/2 + 60, height/2 + 20);
  }
}

void keyPressed() {
  if (!gameOver) {
    if (keyCode == LEFT) {
      paddle.move(-15);
    } else if (keyCode == RIGHT) {
      paddle.move(15);
    }
  }
}

void mousePressed() {
  if (gameOver) {
    // Botón reintentar
    if (mouseX > width/2 - 100 && mouseX < width/2 - 20 &&
        mouseY > height/2 && mouseY < height/2 + 40) {
      startGame();
      gameOver = false;
    }
    // Botón salir
    if (mouseX > width/2 + 20 && mouseX < width/2 + 100 &&
        mouseY > height/2 && mouseY < height/2 + 40) {
      exit();
    }
  }
}

// ------------------ Clases ------------------

class Ball {
  float x, y, r;
  float xspeed, yspeed;
  
  Ball() {
    x = width/2;
    y = height/2;
    r = 10;
    xspeed = 2;
    yspeed = 2;
  }
  
  void update() {
    x += xspeed;
    y += yspeed;
    
    // Rebote en paredes
    if (x < 0 || x > width) xspeed *= -1;
    if (y < 0) yspeed *= -1;
  }
  
  void show() {
    fill(0,255,0);
    ellipse(x, y, r*2, r*2);
  }
  
  void checkPaddle(Paddle p) {
    if (x > p.x && x < p.x + p.w && y + r > p.y && y - r < p.y) {
      yspeed *= -1;
      y = p.y - r; // ajustar posición
    }
  }
  
  boolean checkBlock(Block b) {
    if (x > b.x && x < b.x + b.w && y - r < b.y + b.h && y + r > b.y) {
      yspeed *= -1;
      return true;
    }
    return false;
  }
}

class Paddle {
  float x, y, w, h;
  
  Paddle() {
    w = 80;
    h = 10;
    x = width/2 - w/2;
    y = height - 30;
  }
  
  void show() {
    fill(0, 0, 255);
    rect(x, y, w, h);
  }
  
  void move(float step) {
    x += step;
    x = constrain(x, 0, width - w);
  }
}

class Block {
  float x, y, w, h;
  
  Block(float x_, float y_, float w_, float h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
  }
  
  void show() {
    fill(255); // ← bloques blancos
    rect(x, y, w, h);
  }
}

// ------------------ Reinicio ------------------

void startGame() {
  ball = new Ball();
  paddle = new Paddle();
  blocks = new ArrayList<Block>();
  score = 0;
  
  int cols = 10;
  int rows = 5;
  int blockW = width / cols;
  int blockH = 20;
  
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      blocks.add(new Block(i * blockW, j * blockH, blockW, blockH));
    }
  }
}
