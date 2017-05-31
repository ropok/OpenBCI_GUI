
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

import java.text.DateFormat;
import java.text.SimpleDateFormat;

DateFormat tanggalFormat = new SimpleDateFormat("HH:mm:ss.SSS");

W_Jalerse jalerse;
// W_ambilDataKe2 jupukKe2;
class W_Jalerse extends Widget {

  //Start Running
  //timer
  float lastTimeCheck;
  float timeInterval;
  int timeIntervalMili;
  public int detik;
  public int nomorWidget = 1;
  float milidetik;
  int waktuDetik = -1;
  int ulang = 0;

  public int fokus = 7;

  //Variabel Kedip, time in ms
  boolean bMerah = true;
  boolean bBlinkMerah;
  int time11 = 0;
  int time12 = 0;
  int timeTelur = 0;
  int timeDelay11 = 45;
  int timeDelay12 = 40;

  //telur
  float jatuh;
  float ypos = 0;
  float yspeed = 10;

  //to see all core variables/methods of the Widget class, refer to Widget.pde
  //put your custom variables here...
  Button widgetTemplateButton;
  Button sudahSelesaiButton;

  //.txt Focus
  String outputName = "ColorFocus/" + fileName + "_colorFocus.txt";
  PrintWriter outputText;
  int counterText;
  String focus = "N";

  public boolean nulisData = false;

  W_Jalerse(PApplet _parent){
    super(_parent); //calls the parent CONSTRUCTOR method of Widget (DON'T REMOVE)
    // noLoop();
    widgetTemplateButton = new Button (x + w/2, y + h/2, 400, navHeight, "Tekan Spasi Untuk Memulai Ambil Data ke-1", 12);
    widgetTemplateButton.setFont(p4, 14);


    sudahSelesaiButton = new Button (x + w/2, y + h/2, 200, navHeight, "Sudah Selesai", 12);
    sudahSelesaiButton.setFont(p4, 14);

    //timer
    detik = waktuDetik;
    lastTimeCheck = millis();
    timeInterval = 1000;


    //.txt Focus
    counterText = 0;
    outputText = createWriter(outputName);
    outputText.println("No." + "\t" + "Fokus" + "\t\t" + "Waktu");
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

  void keranjangTelur(){
    fill(142,142,147);
    stroke(0);
    arc(mouseX, y+300, 160, 160, 0, PI, CHORD); 
  }

  void telur(){
    jatuh = random (x,h);
    stroke(0);
    fill(255);
    ellipse(jatuh, ypos, 70, 110);
    ypos = ypos + yspeed;

  }

  void jatuhTelur(){
      if(millis() - timeTelur >= random(200, 1000)){
        timeTelur = millis();
        telur(); 
      }

  }

  void pindahWidget(){
    if(key == '1') {fokus = 7; isRunning = false; nomorWidget = 1; widgetTemplateButton.setString("Tekan Spasi Untuk Memulai Ambil Data ke-1");}
    if(key == '2') {fokus = 7; isRunning = false; nomorWidget = 2; widgetTemplateButton.setString("Tekan Spasi Untuk Memulai Ambil Data ke-2");}
    if(key == '3') {fokus = 7; isRunning = false; nomorWidget = 3; widgetTemplateButton.setString("Tekan Spasi Untuk Mulai Bermain");}
    // if(keyCode == LEFT) fokus = 1;
    // if(keyCode == RIGHT) fokus = 0;
    // if(keyCode == UP) fokus = 5;
    // println (fokus);
  }

  void tekanFokus(){
    // if(key == 'A' || key == 'a' || keyCode == LEFT) focus = "LEFT";
    // if(key == 'D' || key == 'd' || keyCode == RIGHT) focus = "RIGHT";
    // if(key == 'S' || key == 's' || keyCode == UP) focus = "MIDDLE";
    if(keyPressed){
    if(keyCode == LEFT) focus = "LEFT";
    if(keyCode == RIGHT) focus = "RIGHT";
    // if(keyCode == UP) focus = "UP";
    }
    else focus = "N";
  }

  void tulisData(){

    Date tanggal = new Date();

          outputText.println(counterText + ", " + focus + ", " + tanggalFormat.format(tanggal));

          // outputText.println(counterText + ", " + focus + ", " + hour() + ":" + minute() + ":" + second() + ";" + millis());
          // outputText.println(counterText + ", " + focus + ", " + hour() + ":" + minute() + ":" + second() + ";" + millis());
          // outputText.println(counterText + ", " + focus + ", " + hour() + ":" + minute() + ":" + second() + ";" + millis());
          // if(counterText%10 == 0 || counterText%7 == 0 ) outputText.println(counterText + ", " + focus + ", " + hour() + ":" + minute() + ":" + second() + ";" + millis());
          // outputText.println((counterText+1) + ", " + focus + ", " + hour() + ":" + minute() + ":" + second() + ";" + millis());
          // outputText.println((counterText+2) + ", " + focus + ", " + hour() + ":" + minute() + ":" + second() + ";" + millis());
          outputText.flush();
          counterText++;
  }

  
  void update(){
    super.update(); //calls the parent update() method of Widget (DON'T REMOVE)
    //put your code here...
    pindahWidget(); //Agar tombol ganti widget senantiasa aktif
    // tekanFokus();

      if (isRunning)
        if (eegDataSource == DATASOURCE_SYNTHETIC || eegDataSource == DATASOURCE_GANGLION){
          tulisData();
        }
    // if(nulisData == true) tulisData();
  }

  void draw(){
    super.draw(); //calls the parent draw() method of Widget (DON'T REMOVE)

    //put your code here... //remember to refer to x,y,w,h which are the positioning variables of the Widget class
    // jatuhTelur();
    ////////////////////////////////////////////////////
    //
    //    Mode Widget Pertama - Ambil Data 1
    //  1. Kotak Putih (blank) muncul selama 3 detik
    //  2. Kotak Merah (di kiri) muncul selama 5 detik
    //  3. Kotak Putih (blank) muncul selama 3 detik
    //  4. Kotak Biru  (di kanan) muncul selama 5 detik
    //  5. 1-4 diulangi sebanyak 2 kali (total 3 kali dengan yang pertama)
    //
    ///////////////////////////////////////////////////,
    if(nomorWidget == 1){
      pushStyle();
      if (isRunning)
        if (eegDataSource == DATASOURCE_SYNTHETIC || eegDataSource == DATASOURCE_GANGLION){
          timerDetik();
          // tulisData();
          if(ulang < 3){
            if(detik == waktuDetik) {kotakPutih(); focus = "N"; /*tulisData();*/}
            if(detik >= 3 && detik < 8) {pushStyle(); kotakMerahKedip(); focus = "LEFT"; /*tulisData();*/ popStyle();}
            if(detik >= 8 && detik < 11) {kotakPutih(); focus = "N"; /*tulisData();*/}
            if(detik >= 11 && detik < 16) {pushStyle(); kotakBiruKedip(); focus = "RIGHT"; /*tulisData();*/ popStyle();}
            if(detik == 16) {detik = waktuDetik; ulang += 1;}
          } else {sudahSelesaiButton.draw(); isRunning = false;}
        }
      if (isRunning == false){
        detik = waktuDetik; 
        widgetTemplateButton.draw();
        ulang = 0;
        pindahWidget();
      }
      popStyle();
    }


    ////////////////////////////////////////////////////
    //
    //    Mode Widget Kedua - Ambil Data 2
    // 1. Dua Kotak warna biru dan merah muncul secara bersamaan
    // 2. Sampel diminta untuk fokus pada salah satu kotak
    // 3. Jika akan fokus ke kotak Merah, terlebih dahulu sampel menekan Tombol Keyboard Arah Kiri/Left Directional Button (←)
    // 4. Jika akan fokus ke kotak Biru, terlebih dahulu sampel menekan Tombol Keyboard Arah Kanan/Right Directional Button (→)
    // 5. Jika akan fokus ke warna Putih (Relax), terlebih dahulu sampel menekan Tombol Keyboard Arah Atas/Up Directional Button (↑)
    // 6. Tiap penekanan tombol keyboard arah akan dicatat didalam DataLogging
    //
    ///////////////////////////////////////////////////,
    if(nomorWidget == 2){
      pushStyle();
      if (isRunning)
        if (eegDataSource == DATASOURCE_SYNTHETIC || eegDataSource == DATASOURCE_GANGLION){
          tekanFokus(); 
          // outputText.println(counterText + "," + "\t" + focus + "\t\t" + hour() + ":" + minute() + ":" + second() + ";" + millis());
          // tulisData();
          timerDetik();

          pushStyle();
          kotakMerahKedip();
          popStyle();

          pushStyle();
          kotakBiruKedip();
          popStyle();
        } 
      if (isRunning == false){
        detik = waktuDetik; 
        widgetTemplateButton.draw();
        ulang = 0;
        pindahWidget();
     }
      popStyle();
    }


    ////////////////////////////////////////////////////
    //
    //    Mode Widget Ketiga - Implementasi Game Keranjang Telur
    // 1. Dua Kotak warna biru dan merah muncul secara bersamaan
    // 2. Terdapat keranjang telur di tengah, akan ada telur jatuh secara random dari atas ke bawah
    // 3. Sampel diminta untuk menangkap telur dengan keranjang dengan cara fokus pada salah satu kotak (merah dan biru)
    // 4. Fokus Kotak Merah (di kiri) untuk menggerakkan keranjang ke kiri
    // 5. Fokus Kotak Biru (di kanan) untuk menggerakkan keranjang ke kanan
    // 6. Jika Berhasil menangkap telur, skor tangkap bertambah 1
    // 7. Jika Gagal menangkap telur (telur jatuh sampai bawah keranjang), skor pecah bertambah 1
    // 8. Skor digunakan untuk mengukur akurasi pada implementasi ini dengan membagi skor tangkap dengan jumalh skor tangkap dan skor pecah
    //    ( Akurasi = skorTangkap/(skorTangkap+skorPecah) )
    // 2. Sampel diminta untuk fokus pada salah satu kotak
    // 3. Jika akan fokus ke kotak Merah, terlebih dahulu sampel menekan Tombol Keyboard Arah Kiri/Left Directional Button (<-)
    // 4. Jika akan fokus ke kotak Biru, terlebih dahulu sampel menekan Tombol Keyboard Arah Kanan/Right Directional Button (->)
    // 5. Tiap penekanan tombol keyboard arah akan dicatat didalam DataLogging
    //
    ///////////////////////////////////////////////////,
    if(nomorWidget == 3){
      pushStyle();
      if (isRunning)
        if (eegDataSource == DATASOURCE_SYNTHETIC || eegDataSource == DATASOURCE_GANGLION){
          timerDetik(); 

          pushStyle();
          kotakMerahKedip();
          popStyle();

          pushStyle();
          kotakBiruKedip();
          popStyle();

          pushStyle();
          keranjangTelur();
          popStyle();
        }
      if (isRunning == false){
        detik = waktuDetik; 
        widgetTemplateButton.draw();
        ulang = 0;
        pindahWidget();
      }
      popStyle();
    }
  }

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