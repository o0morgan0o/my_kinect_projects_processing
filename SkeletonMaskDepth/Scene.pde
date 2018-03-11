float sceneSize = 300;



void drawScene(){


    //dessine la boite env gloabale
    stroke(255);
    noFill();
    box(sceneSize);
    //dessine les mains
      RightBox.display();
      LeftBox.display();   


    
    if(LeftBox.state=="open"){
        println("new part");
        p= new Particle(LeftBox);  
    }


    //part
    if(p!=null){
        p.update();
        p.display();
    }
   
    //dessine ligne qui relie les mains
    stroke(255);
    strokeWeight(10);
    line(RightBox.position.x, RightBox.position.y, RightBox.position.z, LeftBox.position.x, LeftBox.position.y, LeftBox.position.z);







}
