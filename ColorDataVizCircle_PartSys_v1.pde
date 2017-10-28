/***********
 IMAGE ANALIZER TO CREATE A .CDV (COLOR DATA VIZ) FILE. Code by Quelic Berga
 ************/



/*** working in 3D ***/


Estructura es;
PGraphics Visualitzacio;
PGraphics Detalls;
String InterActual = "";
String DescripActual = "";
String URLActual = "";


/*** Getting DATA of the folder or images**/
import java.util.Date;
String path = sketchPath();
String[] filenames;
PVector[] Suma;
boolean data = false;
boolean update = false;


int resolucio = 12; // nombre de linees en el radi
int tamanyDiametre = 550; // tamany del cercle de color



void setup() {
  size(1700, 1000, P3D); // mida de la pantalla
  background(0); // començem en negre 
  colorMode(HSB); // tipus de color
  ellipseMode(CENTER); // cercles es dibuixen desde el seu centre 
  Visualitzacio = createGraphics(width-width/3, height-height/10, P3D);
  Detalls = createGraphics(width/3, height-height/10);
  es = new Estructura(new PVector ((width-width/3)/2, (height-height/10)/2), tamanyDiametre, resolucio); // creem la estuctura amb els valors desitjats ( posició x i y, mida diametre, i nombre de punts per aspa)
  es.crea(); // creem els punts i els hi assignem la posició i color.
  //ortho(-width/2, width/2, -height/2, height/2);
}

void draw() {
  background(0);
  textSize(64);
  text("Colors dominants en les interfícies", 20, 72);
  Detalls.beginDraw();
  Detalls.fill(255);
  Detalls.rect(0, 0, width, height);
  Detalls.textSize(36);
  Detalls.fill(0);
  Detalls.text("Interficie", 20, 50);
  Detalls.text(InterActual, 30, 100);

  Detalls.textSize(24);
  Detalls.fill(0);
  Detalls.text("Descripció", 20, 160);
  Detalls.textSize(10);
  Detalls.textAlign(LEFT, TOP);
  Detalls.text(DescripActual, 30, 200, 220, 250);
 
  Detalls.endDraw();
  Visualitzacio.beginDraw();
  Visualitzacio.background(0);
  /* Visualitzacio.fill(0, 20); // fem un efecte de lleugera transparència per a suavitzar l'animació i interacció.
   Visualitzacio.rect(0, 0, width, height); // dibuixem un rectangle semi transparent en lloc de borrar la pantalla */
  es.dibuixa(); // dibuixem l'estructura amb els seus punts.
  Visualitzacio.endDraw();
  image(Visualitzacio, width/100, height/10);
  image(Detalls, 2*(width/100)+Visualitzacio.width, height/10);
}

void keyPressed() {//canviar mètode s'activa al premer qualsevol tecla!
  if (key == 'l' || key == 'L') {
    selectFolder("Select a folder to process:", "folderSelected"); // Crida una finestra local per escollir arxius
  }
  if (key == 'u' || key == 'U') {
  }
}

void folderSelected(File selection) { //Supervisa les carpetes per escollir els arxius.
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    path = selection.getAbsolutePath();
    getinfo(); // Guardem la info en un objecte File[]
  }
}

void getinfo() {
  println("Listing all filenames in a directory: ");
  filenames = listFileNames(path);
  Suma = calcPix(filenames);

  data = true;
  printArray(filenames);
  printArray(Suma);
  update = true;
}


// Seleccionem una carpeta, i guardem els jpg, png i gif en un Array  
String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String na[] = file.list();
    String names[] = new String[0];
    for (int i = 0; i < na.length; i++) {
      if (na[i].endsWith(".jpg")) {
        names = append(names, na[i]);
      }
      if (na[i].endsWith(".png")) {
        names = append(names, na[i]);
      }
      if (na[i].endsWith(".gif")) {
        names = append(names, na[i]);
      }
    }
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}
/*
File[] listFiles(String dir) {
 File file = new File(dir);
 if (file.isDirectory()) {
 File[] files = file.listFiles();
 return files;
 } else {
 // If it's not a directory
 return null;
 }
 }*/

// Calculem color promig per imatge i ho guardem en un vector. 
PVector[] calcPix(String[] dades) {

  PImage[] img = new PImage[dades.length];
  PVector[] Suma = new PVector[dades.length];
  for (int i = 0; i < dades.length; i ++) {

    img[i] = loadImage(path+"/"+dades[i]);

    img[i].loadPixels();
    int size = img[i].width*img[i].height;
    Suma[i] = new PVector (0, 0, 0);
    for (int s = 0; s < size; s++) {
      Suma[i].x += (hue(img[i].pixels[s]));
      Suma[i].y += (saturation(img[i].pixels[s]));
      Suma[i].z += (brightness(img[i].pixels[s]));
    }
    Suma[i].x /= size;
    Suma[i].y /= size;
    Suma[i].z /= size;
  }
  return Suma;
}