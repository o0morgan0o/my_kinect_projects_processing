


class LinePart{
  float xspeed=random(3)-1.5;
  float yspeed=random(6);
   int xpos;
   int ypos;
   float b=random(8);
   float mult=1;
   float trans=0;
   int r=floor(random(150))+50;
   
  
  LinePart(){
  xpos=floor(random(width/2-1));
  ypos=floor(random(height));

  }
  
  void update(){
    
   xpos=floor(xpos+xspeed*mult);
 ypos=floor(ypos+yspeed*mult);
   if(xpos>width/2){
    xpos=0;
   }else if(xpos <0 ){
     xpos=width/2;
   }
      if(ypos>=height-1){
    ypos=0;
   }else if(ypos <0 ){
     ypos=height;
   }
   

  }
  
  void display(){
   stroke(0);
   strokeWeight(1);
   fill(120,0,0);
   //line(0,ypos,width,ypos);
   stroke(r,r/2,0,trans);
   strokeWeight(b);
   point(xpos,ypos);
  }
  
}



import KinectPV2.*;
KinectPV2 kinect;
PImage img;
float a=0;
LinePart[] LineParts= new LinePart[20000];
float max=2000;
float min=50;

void setup(){
  
 size(1024,424);
for(int i=0; i<LineParts.length; i++){
 LineParts[i]=new LinePart(); 
}
 kinect= new KinectPV2(this);
 kinect.enableDepthImg(true);
 kinect.init();
   img=createImage(kinect.WIDTHDepth, kinect.HEIGHTDepth, RGB);
  
}



void draw(){
background(255);

//min=map(mouseX,0, width,0,1000);
//max=map(mouseY,0, height,500,3000);
//if(max<min){
//max= min+1;
//}

min=205;
max=1460;
//println(min + " " +max);
//img.loadPixels();

  PImage dImg= kinect.getDepthImage(); 
  int[] depth= kinect.getRawDepthData();
  
       image(dImg,512,0);


for(int i=0;i<LineParts.length;i++){
        //println(LineParts[i].xpos + " " + LineParts[i].ypos);
 int index=(LineParts[i].xpos)+ width/2*((LineParts[i].ypos));
   //println(floor(LineParts[i].xpos));
   //println(LineParts[i].xpos);
   //   println(LineParts[i].ypos);
   //println(depth[index]);

      LineParts[i].update();
     LineParts[i].display();
   
   
       //println(i + " " + index);
       //println(LineParts[i].xpos + " " + LineParts[i].ypos);
   if(depth[index]< max && depth[index]>min){
     LineParts[i].mult=1.2 ;
   //  LineParts[i].b=51;
     LineParts[i].trans=250;
     

   
   }else{
     LineParts[i].mult=1;
  //  LineParts[i].speed=3; 
   //    LineParts[i].b=120;
       if(LineParts[i].trans>0){
       LineParts[i].trans /= 2;
       //LineParts[i].trans -= 6;
   }else{
     LineParts[i].trans=0;
   }
   }
  

}


}


void mousePressed(){
for(int i=0; i<LineParts.length; i++){
 LineParts[i]=new LinePart(); 
}

}