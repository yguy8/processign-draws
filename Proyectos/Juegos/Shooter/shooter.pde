// Shooter minimalista en Processing
ArrayList<Enemy> enemigos;
ArrayList<Bala> balas;
Nave nave;

void setup() {
  size(600, 400);
  nave = new Nave(width/2, height - 50);
  enemigos = new ArrayList<Enemy>();
  balas = new ArrayList<Bala>();
}

void draw() {
  background(20);
  
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
  if (frameCount % 60 == 0) {
    enemigos.add(new Enemy(random(20, width-20), -20));
  }
  
  // Actualizar y dibujar enemigos
  for (int i = enemigos.size()-1; i >= 0; i--) {
    Enemy e = enemigos.get(i);
    e.update();
    e.display();
    
    // Colisión con balas
    for (int j = balas.size()-1; j >= 0; j--) {
      Bala b = balas.get(j);
      if (dist(e.x, e.y, b.x, b.y) < 15) {
        enemigos.remove(i);
        balas.remove(j);
        break;
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
    x = constrain(x, 20, width-20);
  }
  
  void display() {
    fill(0, 200, 255);
    triangle(x-15, y+15, x+15, y+15, x, y-15);
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
    rect(x-2, y-10, 4, 10);
  }
}

class Enemy {
  float x, y;
  Enemy(float x_, float y_) {
    x = x_;
    y = y_;
  }
  
  void update() {
    y += 3;
  }
  
  void display() {
    fill(255, 50, 50);
    rect(x-10, y-10, 20, 20); // enemigo cuadrado
  }
}
