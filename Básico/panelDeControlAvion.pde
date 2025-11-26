void setup() {
  size(800, 600);
  background(30);
}

void draw() {
  background(30);

  // Marco del panel
  fill(50);
  rect(50, 50, 700, 500);

  // Indicador circular (altímetro)
  fill(0);
  ellipse(200, 200, 150, 150);
  stroke(255);
  line(200, 200, 200, 140); // aguja
  noStroke();
  fill(255);
  textAlign(CENTER);
  text("ALT", 200, 270);

  // Indicador circular (velocímetro)
  fill(0);
  ellipse(400, 200, 150, 150);
  stroke(255);
  line(400, 200, 450, 180); // aguja
  noStroke();
  fill(255);
  text("SPD", 400, 270);

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
  text("HORIZON", 600, 270);

  // Botones rectangulares
  fill(200, 0, 0);
  rect(150, 400, 50, 30);
  fill(0, 200, 0);
  rect(250, 400, 50, 30);
  fill(255, 200, 0);
  rect(350, 400, 50, 30);

  // Etiquetas
  fill(255);
  textAlign(LEFT);
  text("Engine", 150, 450);
  text("Lights", 250, 450);
  text("Landing Gear", 350, 450);
}
