//más realista 
void setup() {
  size(1000, 700);
  surface.setResizable(true); // permitir agrandar la ventana
}

void draw() {
  background(30);

  // Marco del panel
  fill(50);
  rect(50, 50, 900, 600);

  // -------- INSTRUMENTOS PRINCIPALES --------
  // Altímetro
  dibujarInstrumento(200, 200, "ALT", 140, radians(frameCount % 360));

  // Velocímetro
  dibujarInstrumento(400, 200, "SPD", 140, radians((frameCount*2) % 360));

  // Horizonte artificial
  fill(0);
  ellipse(600, 200, 150, 150);
  fill(0, 0, 255);
  arc(600, 200, 150, 150, PI, TWO_PI); // cielo
  fill(150, 75, 0);
  arc(600, 200, 150, 150, 0, PI); // tierra
  stroke(255);
  line(525, 200, 675, 200); // línea horizonte
  noStroke();
  fill(255);
  textAlign(CENTER);
  text("HORIZON", 600, 270);

  // Brújula
  dibujarInstrumento(800, 200, "HDG", 140, radians((frameCount/2) % 360));

  // -------- FILA DE BOTONES --------
  dibujarBoton(200, 500, "Engine", color(200,0,0));
  dibujarBoton(350, 500, "Lights", color(0,200,0));
  dibujarBoton(500, 500, "Landing", color(255,200,0));
  dibujarBoton(650, 500, "Autopilot", color(0,150,255));
  dibujarBoton(800, 500, "Radar", color(255,0,200));
}

// -------- FUNCIONES AUXILIARES --------
void dibujarInstrumento(float cx, float cy, String etiqueta, float radio, float angulo) {
  fill(0);
  ellipse(cx, cy, radio, radio);
  stroke(255);
  line(cx, cy, cx + cos(angulo)*radio/2, cy + sin(angulo)*radio/2); // aguja
  noStroke();
  fill(255);
  textAlign(CENTER);
  text(etiqueta, cx, cy + radio/2 + 20);
}

void dibujarBoton(float x, float y, String etiqueta, color c) {
  fill(c);
  rect(x, y, 100, 40, 5);
  fill(255);
  textAlign(CENTER, CENTER);
  text(etiqueta, x+50, y+20);
}
