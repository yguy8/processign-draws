void setup() {
  size(800, 600);
  surface.setResizable(true);
  textAlign(CENTER, CENTER);
  textSize(14);
}

void draw() {
  background(40);

  // Panel base
  fill(200);
  stroke(100);
  rect(100, 50, 600, 500, 20);

  // Primera fila de instrumentos
  dibujarVelocimetro(180, 130, "SPD", 80);
  dibujarBrújula(400, 130, "HDG", 2);
  dibujarAltimetro(620, 130, "ALT", 20);

  // Segunda fila
  dibujarHorizonte(180, 270);
  dibujarVerticalSpeed(400, 270, "VSI", 0);
  dibujarTurnCoordinator(620, 270);

  // Tercera fila
  dibujarFuelGauge(180, 410, "FUEL", 0.6);
  dibujarDisplay(400, 410, "1200");
  dibujarEngineTemp(620, 410, "ENG", 0.5);

  // Luces de estado
  dibujarLuz(250, 500, "GEAR", color(255, 0, 0));
  dibujarLuz(350, 500, "OIL", color(255, 0, 0));
  dibujarLuz(450, 500, "ALT", color(0, 255, 0));
  dibujarLuz(550, 500, "", color(0, 255, 0));
}

// ------------------ Instrumentos ------------------

void dibujarVelocimetro(float x, float y, String label, float valor) {
  dibujarDial(x, y, label, 0, 160, valor, color(255));
}

void dibujarAltimetro(float x, float y, String label, float valor) {
  dibujarDial(x, y, label, 0, 100, valor, color(255, 0, 0));
}

void dibujarBrújula(float x, float y, String label, float rumbo) {
  dibujarDial(x, y, label, 0, 360, rumbo * 30, color(255));
}

void dibujarVerticalSpeed(float x, float y, String label, float valor) {
  dibujarDial(x, y, label, -20, 20, valor, color(255));
}

void dibujarTurnCoordinator(float x, float y) {
  fill(0);
  ellipse(x, y, 100, 100);
  fill(255);
  text("TURN", x, y + 40);
  fill(255);
  pushMatrix();
  translate(x, y);
  rotate(radians(-15));
  triangle(-10, 0, 10, 0, 0, -20);
  popMatrix();
}

void dibujarFuelGauge(float x, float y, String label, float nivel) {
  fill(0);
  ellipse(x, y, 100, 100);
  fill(255);
  text(label, x, y + 40);
  fill(255, 100, 0);
  float ang = map(nivel, 0, 1, -PI/2, PI/2);
  line(x, y, x + cos(ang)*40, y + sin(ang)*40);
  text("E", x - 30, y);
  text("F", x + 30, y);
}

void dibujarEngineTemp(float x, float y, String label, float nivel) {
  fill(0);
  ellipse(x, y, 100, 100);
  fill(255);
  text(label, x, y + 40);
  fill(255, 100, 0);
  float ang = map(nivel, 0, 1, -PI/2, PI/2);
  line(x, y, x + cos(ang)*40, y + sin(ang)*40);
  text("C", x - 30, y);
  text("H", x + 30, y);
}

void dibujarHorizonte(float x, float y) {
  fill(0);
  ellipse(x, y, 100, 100);
  fill(0, 0, 255);
  arc(x, y, 100, 100, PI, TWO_PI);
  fill(150, 75, 0);
  arc(x, y, 100, 100, 0, PI);
  stroke(255);
  line(x - 40, y, x + 40, y);
  noStroke();
  fill(255);
  text("HORIZON", x, y + 40);
}

void dibujarDisplay(float x, float y, String texto) {
  fill(0, 150, 0);
  rect(x - 50, y - 25, 100, 50, 5);
  fill(255, 255, 0);
  textSize(20);
  text(texto, x, y);
  textSize(14);
}

// ------------------ Utilidades ------------------

void dibujarDial(float x, float y, String label, float min, float max, float valor, color agujaColor) {
  fill(0);
  ellipse(x, y, 100, 100);
  fill(255);
  text(label, x, y + 40);
  float ang = map(valor, min, max, -PI/2, PI/2);
  stroke(agujaColor);
  line(x, y, x + cos(ang)*40, y + sin(ang)*40);
  noStroke();
}

void dibujarLuz(float x, float y, String texto, color c) {
  fill(c);
  rect(x, y, 60, 30, 5);
  fill(255);
  text(texto, x + 30, y + 15);
}
