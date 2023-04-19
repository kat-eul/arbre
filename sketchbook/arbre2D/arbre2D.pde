/*****************************************************************
 * arbre3D.pde
 * Simule un arbre en 3D
 * @author Katel HIGNARD
 */

/*****************************************************************
 * Variables Globales
 */
int userDiameter = 10;
Tree2D tree;

/*****************************************************************
 * Programme principal
 */

void setup(){
 size(1000,800);
 background(0);
 fill(255);
 stroke(0,255,0);
 noStroke();
 
 tree = new Tree2D(userDiameter);
 tree.drawLastDisk();
}

void draw(){

  tree.generateNewDisk();
  tree.drawLastDisk();
  
  delay(100);
}

void keyPressed(){
  println("FRAME SAVED");
  saveFrame();
}
