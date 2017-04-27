
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

W_ambilDataKe2 jupukKe2;
class W_ambilDataKe2 extends Widget {

  //Start Running
  //timer
  float lastTimeCheck;
  float timeInterval;
  int timeIntervalMili;
  public int detik;
  float milidetik;
  int waktuDetik = -1;
  int ulang = 0;

  //Variabel Kedip
  boolean bMerah = true;
  boolean bBlinkMerah;
  int time11 = 0;
  int time12 = 0;
  int timeDelay11 = 45;
  int timeDelay12 = 40;

  //to see all core variables/methods of the Widget class, refer to Widget.pde
  //put your custom variables here...
  Button widgetTemplateButton;
  Button sudahSelesaiButton;

  W_ambilDataKe2(PApplet _parent){
    super(_parent); //calls the parent CONSTRUCTOR method of Widget (DON'T REMOVE)
    // noLoop();
    widgetTemplateButton = new Button (x + w/2, y + h/2, 400, navHeight, "Tekan Spasi Untuk Memulai Widget Ke-2", 12);
    widgetTemplateButton.setFont(p4, 14);


    sudahSelesaiButton = new Button (x + w/2, y + h/2, 200, navHeight, "Sudah Selesai", 12);
    sudahSelesaiButton.setFont(p4, 14);

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

  void kotakMerahKedip(){
      if(millis() - time11 >= timeDelay11){
        time11 = millis();
        kotakPutih();
      }
    else kotakMerah();
  }

  void kotakBiruKedip(){
      if(millis() - time12 >= timeDelay12){
        time12 = millis();
        kotakPutih();
      }
    else kotakBiru();
  }

  void kotakPutih(){
    noStroke();
      fill(255);
      rect(x,y-1,w,h+1);
  }

  void kotakMerah(){
    noStroke();
      fill(255,3,3);
      rect(x,y+400,w/4,h);
  }

  void kotakBiru(){
    noStroke();
      fill(3,255,232);
      rect(w-(w/4),y+400,w/4,h);
  }
  void update(){
    super.update(); //calls the parent update() method of Widget (DON'T REMOVE)
    //put your code here...
    
    if(key == 'A' || key == 'a' || keyCode == LEFT) widgetTemplateButton.setString("Tombol Kiri tertekan");
    if(key == 'D' || /*key == 'd' ||*/ keyCode == RIGHT) widgetTemplateButton.setString("Tombol Kanan tertekan");
    // println("Key code pressed: " + keyCode);
  }

  void draw(){
    super.draw(); //calls the parent draw() method of Widget (DON'T REMOVE)

    //put your code here... //remember to refer to x,y,w,h which are the positioning variables of the Widget class
    //   void keyPressed(){
    // super.keyPressed();
    // if(keyCode == LEFT || key == 'a') println("mochi");
      // widgetTemplateButton.setString("Tombol Kiri tertekan");
  // }
    pushStyle();
    /*
    Aturan Training Data
    Kotak Biru = pilih dengan left
    Kotak Merah = pilih dengan right
    Tiap pemilihan dicatat di ambilData
    */
    if (isRunning)
    if (eegDataSource == DATASOURCE_SYNTHETIC || eegDataSource == DATASOURCE_GANGLION){
    timerDetik();
    kotakMerahKedip();
    kotakBiruKedip();
    }

    if (isRunning == false){
      detik = waktuDetik; 
      widgetTemplateButton.draw();
      ulang = 0;
    }
    popStyle();
  }

  // void keyPressed(){
  //   super.keyPressed();
  //   if(keyCode == LEFT || key == 'a') println("mochi");
  //   redraw();
  //     // widgetTemplateButton.setString("Tombol Kiri tertekan");
  // }


  void screenResized(){
    super.screenResized(); //calls the parent screenResized() method of Widget (DON'T REMOVE)

    //put your code here...
    widgetTemplateButton.setPos(x + w/2 - widgetTemplateButton.but_dx/2, y + h/2 - widgetTemplateButton.but_dy/2);
    sudahSelesaiButton.setPos(x + w/2 - widgetTemplateButton.but_dx/2, y + h/2 - widgetTemplateButton.but_dy/2);
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