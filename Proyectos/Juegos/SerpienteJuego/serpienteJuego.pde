// Juego de la víbora (Snake)

int cols, rows;
int rez = 20; // tamaño de cada celda
Snake snake;
PVector food;
int score = 0;       // contador de manzanas
float speed = 1;     // velocidad inicial
boolean gameOver = false; // estado del juego

void setup() {
  size(400, 400);
  frameRate(speed);
  cols = width / rez;
  rows = height / rez;
  snake = new Snake();
  foodLocation();
}

void draw() {
  background(51);
  
  if (!gameOver) {
    // Actualizar y mostrar la víbora
    snake.update();
    snake.show();
    
    // Comprobar si come la comida
    if (snake.eat(food)) {
      foodLocation();
      score++;
      
      // Cada 2 manzanas aumenta la velocidad en 0.01
      if (score % 2 == 0) {
        speed += 0.01;
        frameRate(speed);
      }
    }
    
    // Dibujar comida
    fill(255, 0, 0);
    rect(food.x * rez, food.y * rez, rez, rez);
    
    // Comprobar colisiones
    snake.death();
    
    // Mostrar puntuación y velocidad
    fill(255);
    textSize(16);
    text("Puntos: " + score, 10, 20);
    text("Velocidad: " + nf(speed,1,2), 10, 40);
    
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
    
    // Botón abandonar
    fill(200, 0, 0);
    rect(width/2 + 20, height/2, 80, 40);
    fill(255);
    text("Salir", width/2 + 60, height/2 + 20);
  }
}

void foodLocation() {
  food = new PVector(floor(random(cols)), floor(random(rows)));
}

class Snake {
  ArrayList<PVector> body;
  PVector dir;
  
  Snake() {
    body = new ArrayList<PVector>();
    body.add(new PVector(floor(cols/2), floor(rows/2)));
    dir = new PVector(1, 0);
  }
  
  void update() {
    PVector head = body.get(body.size()-1).copy();
    head.add(dir);
    body.add(head);
    body.remove(0);
  }
  
  void show() {
    fill(0, 255, 0);
    for (PVector part : body) {
      rect(part.x * rez, part.y * rez, rez, rez);
    }
  }
  
  void setDir(int x, int y) {
    dir = new PVector(x, y);
  }
  
  boolean eat(PVector pos) {
    PVector head = body.get(body.size()-1);
    if (head.equals(pos)) {
      body.add(pos.copy()); // crecer
      return true;
    }
    return false;
  }
  
  void death() {
    PVector head = body.get(body.size()-1);
    for (int i = 0; i < body.size()-1; i++) {
      PVector part = body.get(i);
      if (part.equals(head)) {
        gameOver = true;
      }
    }
    // colisión con bordes
    if (head.x < 0 || head.x >= cols || head.y < 0 || head.y >= rows) {
      gameOver = true;
    }
  }
}

void keyPressed() {
  if (!gameOver) {
    if (keyCode == UP) {
      snake.setDir(0, -1);
    } else if (keyCode == DOWN) {
      snake.setDir(0, 1);
    } else if (keyCode == RIGHT) {
      snake.setDir(1, 0);
    } else if (keyCode == LEFT) {
      snake.setDir(-1, 0);
    }
  }
}

void mousePressed() {
  if (gameOver) {
    // Botón reintentar
    if (mouseX > width/2 - 100 && mouseX < width/2 - 20 &&
        mouseY > height/2 && mouseY < height/2 + 40) {
      restartGame();
    }
    // Botón salir
    if (mouseX > width/2 + 20 && mouseX < width/2 + 100 &&
        mouseY > height/2 && mouseY < height/2 + 40) {
      exit();
    }
  }
}

void restartGame() {
  snake = new Snake();
  foodLocation();
  score = 0;
  speed = 1;
  frameRate(speed);
  gameOver = false;
}
