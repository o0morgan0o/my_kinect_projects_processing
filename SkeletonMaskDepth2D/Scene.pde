float sceneSize = 300;
int randomRed=80;
int randomGreen=0;
int randomBlue= 0;
String isNewColor="";


void drawScene(){

    //dessine la boite env gloabale
    stroke(255);
    noFill();

    //dessine les mains
      RightBox.display(RightBox);
      LeftBox.display(LeftBox);   

    
    if(LeftBox.state=="open" && frameCount % 1 == 0){
                systems.add(new ParticleSystem(LeftBox));
    }

    //tirage d'une nouvelle couleur lorsque main droite est ouverte
    if(RightBox.state=="open" && frameCount % 1 == 0){
            randomRed= round(random(255));
            randomGreen= round(random(255));
            randomBlue= round(random(255));
            isNewColor="New Color";
    }

    if(RightBox.state=="closed" && frameCount % 1 == 0){
                isNewColor="";
    }




    pushMatrix();
        strokeWeight(2);
        fill(255);
        rect(0,0,600,100);
        translate(0,40);
        LeftBox.displayPosition();
        translate(0,20);
        RightBox.displayPosition();
        translate(0,20);
        text(frameRate,0,0);
    popMatrix();


}
