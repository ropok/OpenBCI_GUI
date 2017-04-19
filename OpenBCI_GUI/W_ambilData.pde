
////////////////////////////////////////////////////
//
//    W_template.pde (ie "Widget Template")
//
//    This is a Template Widget, intended to be used as a starting point for OpenBCI Community members that want to develop their own custom widgets!
//    Good luck! If you embark on this journey, please let us know. Your contributions are valuable to everyone!
//
//    Created by: Conor Russomanno, November 2016
//
///////////////////////////////////////////////////,

W_ambilData jupuk;
class W_ambilData extends Widget {

  //Start Running

  public final static String mulaiAmbilData1 = "Belum Mulai";
  public final static int flagMulai = 0; 
  public final static boolean repter = false;

  //timer
  float lastTimeCheck;
  float timeInterval;
  public int detik;
  int waktuDetik = -1;
  int ulang = 0;

  //to see all core variables/methods of the Widget class, refer to Widget.pde
  //put your custom variables here...
  Button widgetTemplateButton;

  W_ambilData(PApplet _parent){
    super(_parent); //calls the parent CONSTRUCTOR method of Widget (DON'T REMOVE)

    //This is the protocol for setting up dropdowns.
    //Note that these 3 dropdowns correspond to the 3 global functions below
    //You just need to make sure the "id" (the 1st String) has the same name as the corresponding function
    // addDropdown("Dropdown1", "Drop 1", Arrays.asList("A", "B"), 0);
    // addDropdown("Dropdown2", "Drop 2", Arrays.asList("C", "D", "E"), 1);
    // addDropdown("Dropdown3", "Drop 3", Arrays.asList("F", "G", "H", "I"), 3);

    widgetTemplateButton = new Button (x + w/2, y + h/2, 200, navHeight, "Tekan Spasi Untuk Memulai", 12);
    widgetTemplateButton.setFont(p4, 14);
    //widgetTemplateButton.setURL("http://docs.openbci.com/OpenBCI%20Software/");

    //timer
    detik = waktuDetik;
    lastTimeCheck = millis();
    timeInterval = 1000;
  }

  void timerDetik(){
    if (millis() > lastTimeCheck + timeInterval){
      lastTimeCheck = millis();
      detik += 1;
    }
  }

  void kotakPutih(){
    noStroke();
      fill(255);
      rect(x,y-1,w,h+1);
  }

  void kotakMerah(){
    noStroke();
      fill(255,3,3);
      // rect(x,y+500,w,h-30);
      // rect(x0,y0,w0,h0);
      rect(x,y-1,w,h+1);

  }

void kotakBiruTest(){
    fullScreen();
    noStroke();
      fill(3,255,232);
      // rect(x,y+500,w,h-30);
      // rect(x0,y0,w0,h0);
      rect(0,0,w,h+1);

  }

  void kotakBiru(){
    noStroke();
      fill(3,255,232);
      // rect(x,y+500,w,h-30);
      // rect(x0,y0,w0,h0);
      rect(x,y-1,w,h+1);

  }

  // void kotakBiru(){

  // }

  void update(){
    super.update(); //calls the parent update() method of Widget (DON'T REMOVE)
    // if(HardwareSync.flagMulai == 1)
    //   widgetTemplateButton.setString("Sudah Mulai");
    //put your code here...


  }

  void draw(){
    super.draw(); //calls the parent draw() method of Widget (DON'T REMOVE)

    //put your code here... //remember to refer to x,y,w,h which are the positioning variables of the Widget class
    pushStyle();
    //kotakBiruTest();

    // background(51);
    //print(mouseX, " ", mouseY);

    widgetTemplateButton.draw();
    // if(widgetTemplateButton.Text == "1")
    //   widgetTemplateButton.setString("2");

    /*
    Aturan Warna
    0-3 detik : kotakPutih
    3-8 detik : kotakMerah
    8-11 detik : kotakPutih
    11-16 detik : kotakBiru
    */
    if (isRunning)
    if (eegDataSource == DATASOURCE_SYNTHETIC){
    timerDetik();
      // widgetTemplateButton.setString("Hore");
      if(ulang < 1){
      if(detik == waktuDetik) kotakPutih();
      if(detik >= 3 && detik < 8) kotakMerah();
      if(detik >= 8 && detik < 11) kotakPutih();
      if(detik >= 11 && detik < 16) kotakBiru();
      if(detik == 16) {detik = waktuDetik; ulang += 1;}
      // widgetTemplateButton.setString("3 detik");
      } //else openBCI.stopDataTransfer();
    println(detik);

    }

    if (isRunning == false){
      // widgetTemplateButton.setString("DULL");
      detik = waktuDetik;
    }



    popStyle();

  }

  void screenResized(){
    super.screenResized(); //calls the parent screenResized() method of Widget (DON'T REMOVE)

    //put your code here...
    widgetTemplateButton.setPos(x + w/2 - widgetTemplateButton.but_dx/2, y + h/2 - widgetTemplateButton.but_dy/2);


  }

  void mousePressed(){
    super.mousePressed(); //calls the parent mousePressed() method of Widget (DON'T REMOVE)

    //put your code here...
    if(widgetTemplateButton.isMouseHere()){
      widgetTemplateButton.setIsActive(true);
    }

  }

  void mouseReleased(){
    super.mouseReleased(); //calls the parent mouseReleased() method of Widget (DON'T REMOVE)

    //put your code here...
    if(widgetTemplateButton.isActive && widgetTemplateButton.isMouseHere()){
      widgetTemplateButton.goToURL();
    }
    widgetTemplateButton.setIsActive(false);

  }

  //add custom functions here
  void customFunction(){
    //this is a fake function... replace it with something relevant to this widget

  }

};

//These functions need to be global! These functions are activated when an item from the corresponding dropdown is selected
// void Dropdown1(int n){
//   println("Item " + (n+1) + " selected from Dropdown 1");
//   if(n==0){
//     //do this
//   } else if(n==1){
//     //do this instead
//   }

//   closeAllDropdowns(); // do this at the end of all widget-activated functions to ensure proper widget interactivity ... we want to make sure a click makes the menu close
// }

// void Dropdown2(int n){
//   println("Item " + (n+1) + " selected from Dropdown 2");
//   closeAllDropdowns();
// }

// void Dropdown3(int n){
//   println("Item " + (n+1) + " selected from Dropdown 3");
//   closeAllDropdowns();
// }
