float angulo = 0; // ángulo inicial

void setup() {
  size(600, 400);
}

void draw() {
  background(135, 206, 235); // cielo azul
  translate(width/2, height/2);

  // Aplicar rotación según el ángulo
  rotate(radians(angulo));

  // Dibujar avión simple
  fill(255);
  rectMode(CENTER);
  rect(0, 0, 150, 20); // cuerpo
  rect(-50, -20, 40, 10); // ala izquierda
  rect(50, -20, 40, 10);  // ala derecha
}

// Detectar teclas
void keyPressed() {
  if (keyCode == UP) {
    angulo += 5; // inclina hacia arriba
  } else if (keyCode == DOWN) {
    angulo -= 5; // inclina hacia abajo
  }
}
