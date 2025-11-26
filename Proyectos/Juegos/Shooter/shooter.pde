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
    enemigos.add(new Enemy(random(40, width-40), -20));
  }
  
  // Actualizar y dibujar enemigos
  for (int i = enemigos.size()-1; i >= 0; i--) {
    Enemy e = enemigos.get(i);
    e.update();
    e.display();
    
    // Colisión con balas
    for (int j = balas.size()-1; j >= 0; j--) {
      Bala b = balas.get(j);
      if (dist(e.x, e.y, b.x, b.y) < 20) {
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
  Enemy(float x_, float y_) {
    x = x_;
    y = y_;
  }
  
  void update() {
    y += 2;
  }
  
  void display() {
    // Platillo ovalado
    fill(180, 180, 200);
    ellipse(x, y, 50, 20);
    
    // Cúpula superior
    fill(0, 150, 255);
    ellipse(x, y-10, 25, 15);
    
    // Luces inferiores
    fill(255, 200, 50);
    ellipse(x-15, y+8, 5, 5);
    ellipse(x, y+8, 5, 5);
    ellipse(x+15, y+8, 5, 5);
  }
}
