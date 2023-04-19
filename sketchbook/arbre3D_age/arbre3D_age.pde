/*****************************************************************
 * arbre3D_age.pde
 * Simule un arbre en 3D
 * @author Katel HIGNARD
 *
 * Les modications par rapport au sketch "arbre3D" se situe dans la fonctions
 * Tree3D.draw()
 */

void setup(){
 size(1000,1000,P3D);
 frameRate(customFrameRate);
 
 distCam = max(width,height);
 cam = new PeasyCam(this, distCam);
 sizePlatform = min(width,height)/4;
 
 tree = new Tree3D(radius);
}

import peasy.PeasyCam;
/*****************************************************************
 * Variables globales
 */
// Variables utilisateurs
float radius = 5;
int customFrameRate = 23;
color youngerColor = color(66,255,37),
      agedColor = color(146,119,116);
float pourcentMaxRadius = 0.5,
      pourcentMinRadius = 2.0;

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
 fill(50);
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


void draw(){
  background(0);
  createPlatform();
  
  fill(255);
  tree.generateNewTriangle();
  tree.draw(youngerColor,agedColor,pourcentMinRadius,pourcentMaxRadius);
  
  color start = color(10,100,100),
        end = color(70,100,100);
  for(int i=0; i<11 ;i++){
    color inter = lerpColor(start,end,i/10);
    fill(inter);
    
    beginShape();
    vertex(i*10,i*10,10);
    vertex(i*10,i*-10,10);
    vertex(i*-10,i*-10,10);
    vertex(i*-10,i*10,10);
  }
}
