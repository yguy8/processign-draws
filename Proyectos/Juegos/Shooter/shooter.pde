// Shooter minimalista en Processing con vidas, puntos y nave especial
ArrayList<Enemy> enemigos;
ArrayList<Bala> balas;
Nave nave;

int vidas = 3;
int puntos = 0;
boolean naveEspecialActiva = false;

void setup() {
  size(600, 400);
  nave = new Nave(width/2, height - 50);
  enemigos = new ArrayList<Enemy>();
  balas = new ArrayList<Bala>();
}

void draw() {
  background(20);
  
  // Mostrar vidas y puntos
  mostrarHUD();
  
  // Actualizar y dibujar nave
  nave.update();
  nave.display();
  
  // Actualizar y dibujar balas
  for (int i = balas.size()-1; i >= 0; i--) {
    Bala b = balas.get(i);
    b.update();
    b.display();
    if (b.y < 0) {
      balas.remove(i);
    }
  }
  
  // Generar enemigos cada cierto tiempo
  if (frameCount % 60 == 0 && !naveEspecialActiva) {
    enemigos.add(new Enemy(random(40, width-40), -20, false));
  }
  
  // Activar nave especial al llegar a 25 puntos
  if (puntos >= 25 && !naveEspecialActiva) {
    enemigos.add(new Enemy(width/2, -40, true)); // nave grande
    naveEspecialActiva = true;
  }
  
  // Actualizar y dibujar enemigos
  for (int i = enemigos.size()-1; i >= 0; i--) {
    Enemy e = enemigos.get(i);
    e.update();
    e.display();
    
    // Colisión con balas
    for (int j = balas.size()-1; j >= 0; j--) {
      Bala b = balas.get(j);
      if (dist(e.x, e.y, b.x, b.y) < (e.grande ? 40 : 20)) {
        enemigos.remove(i);
        balas.remove(j);
        puntos++;
        break;
      }
    }
    
    // Colisión con la nave
    if (dist(e.x, e.y, nave.x, nave.y) < (e.grande ? 40 : 20)) {
      enemigos.remove(i);
      vidas--;
      if (vidas <= 0) {
        gameOver();
      }
    }
    
    // Si enemigo llega abajo → eliminar
    if (e.y > height) {
      enemigos.remove(i);
    }
  }
}

void keyPressed() {
  if (keyCode == LEFT) {
    nave.moverIzq = true;
  } else if (keyCode == RIGHT) {
    nave.moverDer = true;
  } else if (key == ' ') {
    balas.add(new Bala(nave.x, nave.y-20));
  }
}

void keyReleased() {
  if (keyCode == LEFT) {
    nave.moverIzq = false;
  } else if (keyCode == RIGHT) {
    nave.moverDer = false;
  }
}

// ------------------ HUD ------------------
void mostrarHUD() {
  // Vidas como círculos verdes
  for (int i = 0; i < vidas; i++) {
    fill(0, 255, 0);
    ellipse(width - 30 - i*20, 20, 15, 15);
  }
  
  // Puntos
  fill(255);
  textSize(16);
  text("Puntos: " + puntos, width - 120, 50);
}

void gameOver() {
  background(0);
  fill(255, 0, 0);
  textSize(32);
  textAlign(CENTER, CENTER);
  text("GAME OVER", width/2, height/2);
  noLoop(); // detener el juego
}

// ------------------ CLASES ------------------

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
    
    // Cabina circular
    fill(255);
    ellipse(x, y-10, 15, 15);
    
    // Propulsores laterales y central
    fill(255, 100, 50);
    rect(x-15, y+15, 10, 15); // izquierdo
    rect(x+15, y+15, 10, 15); // derecho
    rect(x, y+20, 10, 15);    // central
    
    // Fuego de los propulsores
    // Izquierdo
    fill(255, 200, 0); // amarillo
    triangle(x-20, y+22, x-10, y+22, x-15, y+35);
    fill(255, 0, 0);   // rojo
    triangle(x-18, y+28, x-12, y+28, x-15, y+42);
    
    // Derecho
    fill(255, 200, 0); // amarillo
    triangle(x+10, y+22, x+20, y+22, x+15, y+35);
    fill(255, 0, 0);   // rojo
    triangle(x+12, y+28, x+18, y+28, x+15, y+42);
    
    // Central
    fill(255, 200, 0); // amarillo
    triangle(x-5, y+28, x+5, y+28, x, y+42);
    fill(255, 0, 0);   // rojo
    triangle(x-4, y+34, x+4, y+34, x, y+48);
    
    // Triángulo verde en la parte superior
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
  
  void update() {
    y -= 8;
  }
  
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
    y += (grande ? 1.2 : 2); // nave grande más lenta
  }
  
  void display() {
    if (grande) {
      // Nave especial grande
      fill(150, 0, 200);
      ellipse(x, y, 100, 40);
      fill(0, 200, 255);
      ellipse(x, y-20, 50, 25);
      fill(255, 200, 50);
      ellipse(x-30, y+15, 10, 10);
      ellipse(x, y+15, 10, 10);
      ellipse(x+30, y+15, 10, 10);
    } else {
      // Platillo normal
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
