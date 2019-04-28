//la conquista app
//by aaron montoya-moraga and guillermo montecinos
//commisioned by maria jose contreras, trinidad piriz & roxana gomez
//based on daniel shiffman's kinect raw depth data example, & Domestik app devolped by montoya-moraga & guillermo montecinos
//v0.0.6
//jun 2018

//import libraries
//image capture
import ipcapture.*;
//syphon connection
import codeanticode.syphon.*;

//objects

//syphon elements
PGraphics canvas;
SyphonServer server;

//variables

//main control vars
int scene = 0; //0: blackout, 1: domestik, 2:moral game, 3:big data, 4: kinect
boolean domestikScene = false;
boolean moralGameScene = false;
boolean bigDataScene = false;
boolean kinectScene = false;

// Domestik Scene vars
//IPCamera image processing vars
//press 1 to toggle cam 1
//press 2 to toggle cam 2
//press 3 to toggle cam 3

//assume three cameras
int numberCameras = 3;

//from library ipcapture
IPCapture[] cams = new IPCapture[numberCameras];

//array for toggling showing each camera
boolean[] showCam = new boolean[numberCameras];

//array for checking if cameras are landscape mode or not
boolean[] isLandscape = new boolean[numberCameras];

//how many cameras show at the same time
int howMany = 0;

//cameras are 640 * 480;
int landscapeWidth = 640;
int landscapeHeight = 480;

int portraitWidth = 480;
int portraitHeight = 640;

//boolean for toggling color or grayscale
boolean isGray = true;

//setup function
void setup(){
  
  //Processing window
  size(990, 450, P3D);
  
  //image on buffer
  canvas = createGraphics(990, 450, P3D);
  
  //Syphon server initialization
  server = new SyphonServer(this, "Processing Syphon");
  
  // domestik app setup
  setupDomestik();
  
  //for hiding the cursor
  //noCursor();
}

//draw loop
void draw(){
  //Syphon open drawing
  canvas.beginDraw();
  displayDomestik();
  //canvas.rect(mouseX, mouseY, 100,100);
  //Syphon end drawing
  canvas.endDraw();
  //plotting canvas into screen
  //image(canvas,0,0);
  //sending image to madmapper
  server.sendImage(canvas);
}

//===========================
//setup functions
//===========================


//=================================
//Domestik app processing functions
//=================================

void setupDomestik(){
  //change ip address here
  /*
  cams[0] = new IPCapture(this, "http://169.254.232.75/live", "", "");
  cams[1] = new IPCapture(this, "http://169.254.232.75/live", "", "");
  cams[2] = new IPCapture(this, "http://169.254.232.75/live", "", "");
  */
  cams[0] = new IPCapture(this, "http://169.254.134.249/live", "", "");
  cams[1] = new IPCapture(this, "http://169.254.127.63/live", "", "");
  cams[2] = new IPCapture(this, "http://169.254.127.63/live", "", "");
  //start cameras
  for (int i = 0; i < cams.length; i++) {
    cams[i].start();
  }

  //initialize every camera to be not showing
  for (int i = 0; i < showCam.length; i++) {
    showCam[i] = false;
  }
}

void displayDomestik(){
  //get images from cameras
  readCameras();
  howManyCameras();
  displayCameras();
}

void readCameras() {
  //start cameras
  for (int i = 0; i < cams.length; i++) {
    if (cams[i].isAvailable()) {
      cams[i].read();
    }
  }
}

//determine how many cameras are being shown
void howManyCameras() {

  //reset
  howMany = 0;

  //iterate through array and count how many cameras are shown
  for (int i = 0; i < showCam.length; i++) {
    if (showCam[i] == true) {
      //howMany++;
      howMany++;
    }
  }

  //check if cameras are landscape mode or portrait mode
  for (int i = 0; i < cams.length; i++) {
    if (showCam[i] == true) {

      if (cams[i].height == 480) {
        isLandscape[i] = true;
      } else {
        isLandscape[i] = false;
      }
    }
  }
}

void displayCameras() {
  canvas.background(0);
  if (howMany == 0) {
    //black background
    //canvas.background(0);
  } else if (howMany == 1) {
    for (int i = 0; i < cams.length; i++) {
      //check which camera should be displayed
      if (showCam[i] == true) {
        if (isLandscape[i] == true) 
        {
          //one camera in landscape mode
          
          
          canvas.pushMatrix();
          canvas.imageMode(CENTER);
          canvas.translate(width/2,height/2);
          canvas.image(cams[i], 0, 0, width, 480*width/640);
          //canvas.image(cams[i], 0, 0, width, height);
          canvas.popMatrix();
          canvas.imageMode(CORNER);
        } else {
          //one camera in portrait mode
          canvas.imageMode(CENTER);
          float factor = 1.775*height/cams[i].height;
          canvas.image(cams[i], width/2, height/2, factor*cams[i].width, factor*cams[i].height);
        }
      }
    }
  } else if (howMany == 2) {
    int positioned = 0;
    for (int i = 0; i < cams.length; i++) {
      if (showCam[i] == true) {
        if (isLandscape[i] == true) 
        {
          //landscape mode
          canvas.imageMode(CORNER);
          //TODO FIX
          canvas.image(cams[i], positioned*width/2, 0, width/2, height);
          positioned++;
        } else {
          //portrait mode
          canvas.imageMode(CORNER);
          canvas.image(cams[i], positioned*width/2, 0, width/2, height);
          positioned++;
        }
      }
    }
  } else if (howMany == 3) {
    int positioned = 0;
    for (int i = 0; i < cams.length; i++) {
      if (showCam[i] == true) {
        if (isLandscape[i] == true) 
        {
          canvas.imageMode(CORNER);
          //TODO FIX
          canvas.image(cams[i], positioned*width/3, 0, width/3, height);
          positioned++;
        }
        if (isLandscape[i] == false) {
          canvas.imageMode(CORNER);
          canvas.image(cams[i], positioned*width/3, 0, width/3, height);
          positioned++;
        }
      }
    }
  }
  if (isGray == true) {
    //grayscale filter
    //TODO: gray filtering doesn't export to madmapper via syphon. make pixel filtering
    //MAYBE: hice esta funcion maybeGray, quizas funciona? jiji
    canvas.filter(GRAY);
    //maybeGray();
  }
}

void maybeGray() {
  canvas.loadPixels();
  for (int i = 0; i < canvas.width; i++) {
    for (int j = 0; j < canvas.height; j++) {
      color originalColor = pixels[ i + j * canvas.width]; 
      float grayValue = (red(originalColor) + green(originalColor) + blue(originalColor)) / 3;
      pixels[i + j * canvas.width] = color(grayValue);
    }
  }
  canvas.updatePixels();
}


void keyPressed() {
  //main control domestik
  if(key == 'd' || key == 'D'){
    scene = 1;
    println("Domestik scene");
  }
  //main control kinect
  if(key == 'k' || key == 'K'){
    scene = 2;
    println("Kinect scene");
  }
  //main control blackout
  if(key == 'b' || key == 'B'){
    scene = 0;
    println("Blackout scene");
  }

  //stop cameras
  if (key == 'm') {
    for (int i = 0; i < cams.length; i++) {
      cams[i].stop();
    }
  }

  //start cameras
  if (key == 'n') {
    for (int i = 0; i < cams.length; i++) {
      cams[i].start();
    }
  }

  //toggling the showing of cameras
  //according to numbers of keyboard
  //todo: optimize using the boolean array
  if (key == '1') {
    showCam[0] = !showCam[0];
  }

  if (key == '2') {
    showCam[1] = !showCam[1];
  }

  if (key == '3') {
    showCam[2] = !showCam[2];
  }
  
  //turn off all cameras
  if (key == '0') {
    for (int i =0; i < showCam.length; i++) {
      showCam[i] = false;
    }
  }
  
  //toggle color or grayscale
  if (key == 'c') {
    isGray = !isGray;
  }

  //quit program if enter/return is pressed
  if (keyCode == ENTER || keyCode == RETURN) {
    exit();
  }
}
