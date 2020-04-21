import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;


AudioPlayer musica;
Minim minim;
PShader sh;
PShader sh2;
PShader sh3;
PShader sh4;
PImage image;
int idAtaque;
int resultado;
int tuVida;
int vidaEnemigo;
int vidaEnemigoTotal;
int tuAtaque;
int ataqueEnemigo;
int tint;
color backing, bar;
boolean press;

void setup() {
  size(950, 600, P2D);
  minim = new Minim(this);
  musica = minim.loadFile("Master_Hand.mp3");
  sh = loadShader("colores.glsl"); 
  sh2 = loadShader("emboss.glsl"); 
  sh3 = loadShader("monjori.glsl"); 
  sh4 = loadShader("fondo.glsl"); 
  image = loadImage("fer_toretto.png");
  image.resize(200, 200);
  idAtaque = 0;
  resultado = 2;
  tuVida = 250;
  vidaEnemigo = 300;
  vidaEnemigoTotal = vidaEnemigo;
  tuAtaque = 20;
  ataqueEnemigo = 15;
  tint = 0;
  frameRate(15);
  musica.loop();
}


void draw() {
  background(0);
  sh.set("hue", map(abs(cos(millis()/2000)), 0, abs(sin(millis()/1000)), 0, random(TWO_PI)));
  if (vidaEnemigo > 0 && tuVida > 0) {
    if (vidaEnemigo < vidaEnemigoTotal/2 && vidaEnemigo >= vidaEnemigoTotal/4) {
      sh4.set("u_resolution", 300, 300);
      sh4.set("u_time", millis() / 1000.0);
      shader(sh4);
      rect(0, 0, width, height);
      shader(sh);
    } else if (vidaEnemigo < vidaEnemigoTotal/4) {
      sh3.set("time", millis() / 1000.0);
      shader(sh3);
      rect(0, 0, width, height);
      shader(sh2);
    }
    image(image, width/2-100, height/2-200);
    resetShader();

    int max = vidaEnemigoTotal;
    int actual = vidaEnemigo;
    backing = color(255, 0, 0);
    bar = color(0, 255, 0);
    fill(backing);
    stroke(0);
    rect(width/2-100, height/2-250, 200, 20);
    fill(bar);
    rect(width/2-100, height/2-250, map(actual, 0, max, 0, 200), 20);
    fill(255);

    fill(128, 64, 0);
    rect(width-340, height/2+120, 250, 150, 10);
    fill(255);

    textSize(24);
    text("Ataque", width-300, height/2+150); 
    text("Contraataque", width-300, height/2+200); 
    text("Agarre", width-300, height/2+250); 

    switch(idAtaque) {
    case 0:
      triangle(width-330, height/2+130, width-330, height/2+150, width-320, height/2+140);
      break;
    case 1:
      triangle(width-330, height/2+180, width-330, height/2+200, width-320, height/2+190);
      break;
    case 2:
      triangle(width-330, height/2+230, width-330, height/2+250, width-320, height/2+240);
      break;
    }
    
    fill(128, 64, 0);
    rect(10, height/2+75, 155, 40, 10);
    fill(255);

    fill(255);
    text("Tu vida: "+tuVida, 15, height/2+100); 

    fill(128, 64, 0);
    rect(15, height-100, 425, 40, 10);
    fill(255);

    if (resultado ==1) {
      fill(0, 255, 0);
      text("Logras quitar: " + tuAtaque +" puntos de vida", 25, height -75);
    } else if (resultado ==-1) {
      fill(255, 0, 128);
      text("Pierdes: " + ataqueEnemigo +" puntos de vida", 25, height -75);
    } else if (resultado == 0) {
      fill(255);
      text("No hubo daños por ningun lado :(", 25, height -75);
    }
    fill(255);
  } else if (tuVida <= 0) {
    textSize(128);
    fill(255, 0, 0);
    textAlign(CENTER);
    text("HAS PERDIDO", width/2, height/2);
    textSize(24);
    text("Pulsa ESC para cerrar la partida", width/2, height/2+150);
    textAlign(BASELINE);
  } else if (vidaEnemigo <= 0) {
    textSize(128);
    fill(0, 255, 0);
    textAlign(CENTER);
    text("HAS GANADO", width/2, height/2);
    textSize(24);
    text("Pulsa ESC para cerrar la partida", width/2, height/2+150);
    textAlign(BASELINE);
  }

  tint++;
  if (tint >=255) tint = 255;
}




void mouseClicked() {
  press = !press;
}

void keyPressed() {
  if (vidaEnemigo > 0 && tuVida >0) {
    if (keyCode==DOWN) {
      idAtaque++;
      if (idAtaque>2) {
        idAtaque=0;
      }
    } else if (keyCode==UP) {
      idAtaque--;
      if (idAtaque<0) {
        idAtaque=2;
      }
    }
    if (keyCode==ENTER) {
      int ataqueE = (int)random(3);
      resultado = comparaAtaques(idAtaque, ataqueE);
      if (resultado == 1) {
        vidaEnemigo -= tuAtaque;
      } else if (resultado == -1) {
        tuVida -= ataqueEnemigo;
      }
    }
  }
}

int comparaAtaques(int aP, int aE) {
  if (aP == 0 && aE == 1)return -1;  //Contrataque > Ataque
  if (aP == 1 && aE == 0) return 1;

  if (aP == 1 && aE == 2) return -1;  //Agarre > Contraataque 
  if (aP == 2 && aE == 1) return 1;

  if (aP == 2 && aE == 0) return -1;  //Ataque > Agarre
  if (aP == 0 && aE == 2) return 1;

  return 0;
}
