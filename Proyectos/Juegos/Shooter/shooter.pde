// Shooter minimalista en Processing con vidas, puntos, nave especial y pantallas de fin
ArrayList<Enemy> enemigos;
ArrayList<Bala> balas;
Nave nave;

int vidas = 3;
int puntos = 0;
boolean naveEspecialActiva = false;
boolean gameOverActivo = false;
boolean victoriaActiva = false;

void setup() {
  size(600, 400);
  //surface.setResizable(true);
  iniciarJuego();
}

void iniciarJuego() {
  nave = new Nave(width/2, height - 50);
  enemigos = new ArrayList<Enemy>();
  balas = new ArrayList<Bala>();
  vidas = 3;
  puntos = 0;
  naveEspecialActiva = false;
  gameOverActivo = false;
  victoriaActiva = false;
  loop();
}
void draw() {
  background(20);

  // Pantallas de fin
  if (gameOverActivo) {
    mostrarGameOver();
    return;
  }
  if (victoriaActiva) {
    mostrarVictoria();
    return;
  }

  // HUD
  mostrarHUD();

  // Nave
  nave.update();
  nave.display();

  // Balas del jugador
  for (int i = balas.size()-1; i >= 0; i--) {
    Bala b = balas.get(i);
    b.update();
    b.display();
    if (b.y < 0) balas.remove(i);
  }

  // Enemigos normales
  if (frameCount % 60 == 0 && !naveEspecialActiva) {
    enemigos.add(new Enemy(random(40, width-40), -20, false));
  }

  // Activar nave madre al llegar a 25 puntos
  if (puntos >= 25 && !naveEspecialActiva) {
    enemigos.add(new Enemy(width/2, -40, true));
    naveEspecialActiva = true;
  }

  // Actualizar y colisiones de enemigos
  for (int i = enemigos.size()-1; i >= 0; i--) {
    Enemy e = enemigos.get(i);
    e.update();
    e.display();

    // Colisión con balas del jugador
    for (int j = balas.size()-1; j >= 0; j--) {
      Bala b = balas.get(j);
      if (dist(e.x, e.y, b.x, b.y) < (e.grande ? 40 : 20)) {
        if (e.grande) {
          enemigos.remove(i);
          balas.remove(j);
          victoria(); // ganar al destruir la nave madre
          break;
        } else {
          enemigos.remove(i);
          balas.remove(j);
          puntos++;
          break;
        }
      }
    }

    // Colisión con la nave del jugador
    if (dist(e.x, e.y, nave.x, nave.y) < (e.grande ? 40 : 20)) {
      enemigos.remove(i);
      vidas--;
      if (vidas <= 0) gameOver();
    }

    // Eliminar si sale de pantalla
    if (e.y > height) enemigos.remove(i);
  }
}
void keyPressed() {
  if (keyCode == LEFT) nave.moverIzq = true;
  else if (keyCode == RIGHT) nave.moverDer = true;
  else if (key == ' ') balas.add(new Bala(nave.x, nave.y-20));
}

void keyReleased() {
  if (keyCode == LEFT) nave.moverIzq = false;
  else if (keyCode == RIGHT) nave.moverDer = false;
}

// HUD con vidas y puntos
void mostrarHUD() {
  for (int i = 0; i < vidas; i++) {
    fill(0, 255, 0);
    ellipse(width - 30 - i*20, 20, 15, 15);
  }
  fill(255);
  textSize(16);
  text("Puntos: " + puntos, width - 120, 50);
}

// Estados de fin
void gameOver() {
  gameOverActivo = true;
  noLoop();
}

void victoria() {
  victoriaActiva = true;
  noLoop();
}

// Pantalla de Game Over con botones
void mostrarGameOver() {
  background(0);
  fill(255, 0, 0);
  textSize(32);
  textAlign(CENTER, CENTER);
  text("GAME OVER", width/2, height/2 - 80);
  dibujarBotones();
}

// Pantalla de Victoria con botones
void mostrarVictoria() {
  background(0);
  fill(0, 255, 0);
  textSize(24);
  textAlign(CENTER, CENTER);
  text("¡Has derrotado a la nave madre, ganaste el juego!", width/2, height/2 - 80);
  dibujarBotones();
}

// Botones Regresar / Salir
void dibujarBotones() {
  // Regresar
  fill(0, 200, 0);
  rect(width/2 - 100, height/2, 100, 40);
  fill(255);
  textSize(16);
  text("Regresar", width/2 - 100, height/2);

  // Salir
  fill(200, 0, 0);
  rect(width/2 + 100, height/2, 100, 40);
  fill(255);
  text("Salir", width/2 + 100, height/2);
}

// Clic en botones
void mousePressed() {
  if (gameOverActivo || victoriaActiva) {
    // Área del botón Regresar
    if (mouseX > width/2 - 150 && mouseX < width/2 - 50 &&
        mouseY > height/2 - 20 && mouseY < height/2 + 20) {
      iniciarJuego();
    }
    // Área del botón Salir
    if (mouseX > width/2 + 50 && mouseX < width/2 + 150 &&
        mouseY > height/2 - 20 && mouseY < height/2 + 20) {
      exit();
    }
  }
}
class Nave {
  float x, y;
  boolean moverIzq = false;
  boolean moverDer = false;

  Nave(float x_, float y_) {
    x = x_;
    y = y_;
  }

  void update() {
    if (moverIzq) x -= 5;
    if (moverDer) x += 5;
    x = constrain(x, 30, width-30);
  }

  void display() {
    rectMode(CENTER);
    // Cuerpo cuadrado
    fill(0, 200, 255);
    rect(x, y, 25, 50);
    // Cabina
    fill(255);
    ellipse(x, y-10, 15, 15);
    // Propulsores
    fill(255, 100, 50);
    rect(x-15, y+15, 10, 15);
    rect(x+15, y+15, 10, 15);
    rect(x, y+20, 10, 15);
    // Llamas (amarillo y rojo)
    fill(255, 200, 0);
    triangle(x-20, y+22, x-10, y+22, x-15, y+35);
    triangle(x+10, y+22, x+20, y+22, x+15, y+35);
    triangle(x-5, y+28, x+5, y+28, x, y+42);
    fill(255, 0, 0);
    triangle(x-18, y+28, x-12, y+28, x-15, y+42);
    triangle(x+12, y+28, x+18, y+28, x+15, y+42);
    triangle(x-4, y+34, x+4, y+34, x, y+48);
    // Triángulo verde superior
    fill(0, 255, 0);
    triangle(x-10, y-25, x+10, y-25, x, y-40);
  }
}

class Bala {
  float x, y;
  Bala(float x_, float y_) {
    x = x_;
    y = y_;
  }
  void update() { y -= 8; }
  void display() {
    fill(255, 255, 0);
    ellipse(x, y, 8, 8);
  }
}

class Enemy {
  float x, y;
  boolean grande;

  Enemy(float x_, float y_, boolean grande_) {
    x = x_;
    y = y_;
    grande = grande_;
  }

  void update() {
    y += (grande ? 1.2 : 2); // nave madre más lenta
  }

  void display() {
    if (grande) {
      // Nave madre
      fill(150, 0, 200);
      ellipse(x, y, 100, 40);
      fill(0, 200, 255);
      ellipse(x, y-20, 50, 25);
      fill(255, 200, 50);
      ellipse(x-30, y+15, 10, 10);
      ellipse(x, y+15, 10, 10);
      ellipse(x+30, y+15, 10, 10);
    } else {
      // OVNI normal
      fill(180, 180, 200);
      ellipse(x, y, 50, 20);
      fill(0, 150, 255);
      ellipse(x, y-10, 25, 15);
      fill(255, 200, 50);
      ellipse(x-15, y+8, 5, 5);
      ellipse(x, y+8, 5, 5);
      ellipse(x+15, y+8, 5, 5);
    }
  }
}
