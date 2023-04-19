/*****************************************************************
 * arbre3D.pde
 * Simule un arbre en 3D
 * @author Katel HIGNARD
 */

import peasy.PeasyCam;
/*****************************************************************
 * Variables globales
 */
// Variables utilisateurs
float radius = 3;
int customFrameRate = 23;

// Variables autres
PeasyCam cam;
Tree3D tree;
float distCam;
float sizePlatform;


/*****************************************************************
 * Sous-fonctions
 */

/** Génère la plateforme situé sous l'arbre 3D*/
void createPlatform(){
 fill(100);
 noStroke();
 beginShape();
 vertex(sizePlatform,sizePlatform,0);
 vertex(sizePlatform,-sizePlatform,0);
 vertex(-sizePlatform,-sizePlatform,0);
 vertex(-sizePlatform,sizePlatform,0);
 endShape(CLOSE);
}


/*****************************************************************
 * Programme Principal
 */
void setup(){
 size(1000,1000,P3D);
 frameRate(customFrameRate);
 
 distCam = max(width,height);
 cam = new PeasyCam(this, distCam);
 sizePlatform = min(width,height)/4;
 
 tree = new Tree3D(radius);
}

void draw(){
  background(0);
  createPlatform();
  
  fill(255);
  tree.generateNewTriangle();
  tree.draw();  
}
