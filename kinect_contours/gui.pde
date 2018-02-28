
import controlP5.*;
ControlP5 cp5;
Accordion accordion;
color c = color(0, 160, 100);

void gui() {
    cp5 = new ControlP5(this);
    Group g2 = cp5.addGroup("myGroup2")
                .setBackgroundColor(color(0, 64))
                .setBackgroundHeight(150)
                ;
  

  Group g3 = cp5.addGroup("myGroup3")
                .setBackgroundColor(color(0, 64))
                .setBackgroundHeight(150)
                ;
  


     
  cp5.addSlider("threshold")
     .setPosition(60,20)
     .setSize(100,20)
     .setRange(0,100)
     .setValue(19)
     .moveTo(g3)
     ;
     
  cp5.addSlider("minD")
     .setPosition(60,50)
     .setSize(100,20)
     .setRange(0,10000)
     .setValue(0)
     .moveTo(g3)
     ;
     
       cp5.addSlider("maxD")
     .setPosition(60,80)
     .setSize(100,20)
     .setRange(0,15000)
     .setValue(1200)
     .moveTo(g3)
     ;
     
          
       cp5.addSlider("polyFact")
     .setPosition(60,110)
     .setSize(100,20)
     .setRange(0,10)
     .setValue(5.1)
     .moveTo(g3)
     ;
  

  // create a new accordion
  // add g1, g2, and g3 to the accordion.
  accordion = cp5.addAccordion("acc")
                 .setPosition(0,0)
                 .setWidth(200)
                 //.addItem(g2)
                 .addItem(g3)
                 ;
                 
  cp5.mapKeyFor(new ControlKey() {public void keyEvent() {accordion.open(0,1,2);}}, 'o');
  cp5.mapKeyFor(new ControlKey() {public void keyEvent() {accordion.close(0,1,2);}}, 'c');
  cp5.mapKeyFor(new ControlKey() {public void keyEvent() {accordion.setWidth(300);}}, '1');
  cp5.mapKeyFor(new ControlKey() {public void keyEvent() {accordion.setPosition(0,0);accordion.setItemHeight(190);}}, '2'); 
  cp5.mapKeyFor(new ControlKey() {public void keyEvent() {accordion.setCollapseMode(ControlP5.ALL);}}, '3');
  cp5.mapKeyFor(new ControlKey() {public void keyEvent() {accordion.setCollapseMode(ControlP5.SINGLE);}}, '4');
  cp5.mapKeyFor(new ControlKey() {public void keyEvent() {cp5.remove("myGroup1");}}, '0');
  
  accordion.open(0,1,2);
  

  accordion.setCollapseMode(Accordion.MULTI);

}
  

void radio(int theC) {
  switch(theC) {
    case(0):c=color(0,200);break;
    case(1):c=color(255,0,0,200);break;
    case(2):c=color(0, 200, 140,200);break;
    case(3):c=color(0, 128, 255,200);break;
    case(4):c=color(50,128);break;
  }
} 


void shuffle() {
//arcLength= cp5.getController("arclength").getValue()/180.0;
//gap= cp5.getController("gap").getValue();
//offsetangle= cp5.getController("offsetangle").getValue()/180.0;
}