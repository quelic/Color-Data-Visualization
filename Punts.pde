class Punts {
  // De cada punt conservem la següent informació: color, posició, si conté dades, el tamany i la proximitat amb el cursor. 
  color c; 
  PVector pos;
  PVector mida;
  boolean activa;
  String Titol = "";
  String Descripcio = "";
  String Ruta = "";
  String URL = "";
  float prox;

  Punts(PVector pos_, color c_, PVector mida_, String nom) {
    mida = mida_;
    pos = pos_;
    c = c_;
    Titol = nom;
    println(nom);
    if (nom != "") {
      activa = true; // assignem un valor a l'atzar.
    }
    if (activa) {
      Titol = nom;
      Descripcio = "Hola, sóc una explicació de que va tot això, tinguent en compte el color i el comentari de la interfície";
      Ruta = path+" "+nom;  
      URL = "http://www.facebook.com";
    }
  }
  void destaca() {
    Visualitzacio.strokeWeight(2);
    Visualitzacio.stroke(255, 255, 255);
    Visualitzacio.noFill();
    if (activa) {

      Visualitzacio.fill(c);
      Visualitzacio.pushMatrix();
      Visualitzacio.translate(pos.x, pos.y, pos.z);
      Visualitzacio.ellipse(0, 0, mida.x*2, mida.y*2);

      Visualitzacio.popMatrix();
    }
    if (es.on == Titol) {
      Visualitzacio.stroke(255, 128+sin(frameCount/5.0)*128, 255);
      Visualitzacio.strokeWeight(2);
      Visualitzacio.ellipse(pos.x, pos.y, mida.x*5, mida.y*5);
    }
    Visualitzacio.noStroke();
  }

  void dibuixa() {

    Visualitzacio.noStroke();

    prox = dist(es.origen.x+pos.x, es.origen.y+pos.y, mouseX-width/100, mouseY-height/10); // millorar codi! (height/10) esta tirant d'una declaració arbitraria al loop de Draw 
    if (prox < 100) {

      Visualitzacio.fill(c, 30);
      Visualitzacio.pushMatrix();
      Visualitzacio.translate(pos.x, pos.y, pos.z);
      Visualitzacio.ellipse(0, 0, mida.x+100-prox, mida.y+100-prox);
      Visualitzacio.popMatrix();
    } else {
      Visualitzacio.fill(c);
      Visualitzacio.pushMatrix();
      Visualitzacio.translate(pos.x, pos.y, pos.z);
      Visualitzacio.ellipse(0, 0, mida.x, mida.y);

      Visualitzacio.popMatrix();
    }
    if (data == true) {
      /*
// AQUI NOS HEMOS QUEDADO
       for (int i=0; i < filenames.length; i++) {
       color z = color(Suma[i].x,Suma[i].y,Suma[i].z); 
       fill(z);
       translate(Suma[i].x,Suma[i].y);
       rect(0,0,20,20);
       
       }
       */

      if (prox < 10 && activa) {
        InterActual = Titol;
        DescripActual = Descripcio;
        es.on = InterActual;
        println("this is " + es.on);
      }
    }
  }
}