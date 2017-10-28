class Estructura  {

  ArrayList<Punts> punts;
  PVector origen;
  float escala;
  float tamanyCub;
  float posX;
  float posY;
  float posZ;

  String on; 

  Estructura(PVector posicio, int tamanyCub_, int escala_) {
    escala = escala_;
    tamanyCub = tamanyCub_;
    origen = posicio.get();
    punts = new ArrayList<Punts>();
  }
  void dibuixa() {
    Visualitzacio.translate(origen.x, origen.y);

    Visualitzacio.pushMatrix();
    Visualitzacio.rotateZ(radians(-22));
    Visualitzacio.rotateX(radians(12));

    for (Punts p : punts) {

      p.dibuixa();
    }
    Visualitzacio.popMatrix();
    for (Punts p : punts) {

      // p.destaca();
    }
  }
  void crea() {
    for (int h = 0; h < escala; h++) { // es crea la roda de HUE
      for (int s = 0; s < escala; s++) { // es crea la llista per Saturació i Brillo (escala*2)
        for (int b = 0; b < escala; b++) { // es crea la llista per Saturació i Brillo (escala*2)

          color c = color(h*(255.0/escala), s*(255.0/(escala)), b*(255.0/(escala))); // s'assigna al color el HUE i s'exten el Brillo i Saturació al llarg de 512 (256*2) valors

          posX = h*(tamanyCub / escala);
          posY = s*(tamanyCub / escala);
          posZ = b*(tamanyCub / escala);

          // (100 + (s * (tamanyCub / escala)))*cos(radians((h*1.0/escala)*360));
          // posY = (100 + (s * (tamanyCub / escala)))*sin(radians((h*1.0/escala)*360));
          // posX = 
          punts.add(new Punts(new PVector(posX, posY, posZ), c, new PVector((tamanyCub/escala)/15, (tamanyCub/escala)/15), ""));
        }
      }
    }
  }
  void update() {
    if (filenames != null) {
      for (int f = 0; f < filenames.length; f++) { // es crea la roda de HUE
        posX = (Suma[f].x/255)*(tamanyCub);
        posY = (Suma[f].y/255)*(tamanyCub);
        posZ = (Suma[f].z/255)*(tamanyCub);
        // posX = (100 + ((Suma[f].y/2 + (255-Suma[f].z/2)/2)*((escala*2.0)/255.0)  * (tamanyCub / escala)))*cos(radians((Suma[f].x*(255.0/escala))*360));
        //  posY = (100 + ((Suma[f].y/2 + (255-Suma[f].z/2)/2)*((escala*2.0)/255.0) * (tamanyCub / escala)))*sin(radians((Suma[f].x*(255.0/escala))*360));

        //      posX = (100 + ((Suma[f].y/2 + 255-Suma[f].z/2)*(255/(escala*2))  * (tamanyCub / escala)))*cos(radians((Suma[f].x*1.0/escala)*360));
        //      posY = (100 + ((Suma[f].y/2 + 255-Suma[f].z/2)*(255/(escala*2)) * (tamanyCub / escala)))*sin(radians((Suma[f].x*1.0/escala)*360));

        punts.add(new Punts(new PVector(posX, posY, posZ), color(Suma[f].x, Suma[f].y, Suma[f].z), new PVector((tamanyCub/escala)*2, (tamanyCub/escala)*2), filenames[f]));
        println(filenames[f], Suma[f]);
      }
    } else {
      println ("nothing to update!");
    }
  }
}