
class Symbol {
  float x;
  float y;
  String val;


  Symbol(float posX, float posY) {
    x=posX;
    y=posY;
    val= str(char(0x30A0+ round(random(96))));
  }
}


class Stream {

  int totalSymbols;
  float speed;
  Symbol symbol;
  String[] symbols;
  float[] posX;
  float[] posY;
  float x;
  float y;
  boolean first= (round(random(0,2))==1);
  int symbolSize= round(random(10,50));
  PFont f= createFont("ArialMT", symbolSize, true);



  Stream(float X, float Y) {
    totalSymbols=round(random(5, 20));
    speed= (random(1, 2))/speedFactor;
    symbols = new String[totalSymbols];
    posX= new float[totalSymbols];
    posY = new float[totalSymbols];
    x=X;
    y=Y;
  }

  void generateSymbols() {

    for (int i=0; i< symbols.length; i++) {
      symbol= new Symbol(x, y-symbolSize*i);
      symbols[i]=symbol.val;
      posX[i]=symbol.x;
      posY[i]=symbol.y;
    }
  } 

  void rain() {
    for (int i=0; i<symbols.length; i++) {
      if (posY[i]>height + 50) {
        posY[i]=0;
      } else {
        posY[i] += speed;
      }
    }
  }

  void setToRandomValue(int i) {
    if (frameCount % round(random(5, 50)) ==0) {
      symbols[i]= str(char(0x30A0+ round(random(96))));
    }
  }


  void render() {
    // println(symbols.length);
    for (int i=0; i<symbols.length; i++) {
      rain();
      setToRandomValue(i); 
      if(i==0 && first){
 
        fill(180,255,180);
      }else{
      fill(0,  map(speed,0,2, 120,255),  70);

      }

     textFont(f);
            textSize(symbolSize);
      text(symbols[i], posX[i], posY[i]);

    }
  }
}