import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioInput mic;
FFT fft;

void setup() {
  size(800, 600);
  minim = new Minim(this);

  // Captura el micrófono en estéreo con un buffer de 1024 muestras
  mic = minim.getLineIn(Minim.STEREO, 1024);

  // Inicializa el análisis FFT
  fft = new FFT(mic.bufferSize(), mic.sampleRate());
}

void draw() {
  background(0);

  // Analiza el sonido en tiempo real
  fft.forward(mic.mix);

  // Dibujar barras tipo ecualizador
  for (int i = 0; i < fft.specSize(); i++) {
    stroke(255);
    line(i*4, height, i*4, height - fft.getBand(i)*5);
  }

  // Visual extra: círculo que late con el volumen del micrófono
  float amp = mic.mix.level() * 500;
  noStroke();
  fill(150 + amp, 100, 255 - amp, 150);
  ellipse(width/2, height/2, amp, amp);
}
