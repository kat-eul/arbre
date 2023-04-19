/*****************************************************************
 * Tree2D.pde
 * Définit un arbre 2D, généré par une suite de disques
 * @author Katel HIGNARD
 */
 
public class Tree2D{
  private ArrayList<PVector> posDisks;
  private float diameter;
  
  
  /*****************************************************************
   * Constructeur
   * @param d le diametre des disques
   */
  public Tree2D(float d){
    this.posDisks = new ArrayList<PVector>();
    this.diameter = d;
    this.posDisks.add(new PVector(width/2,height-this.diameter/2));
  }
  
  /*****************************************************************
   * Méthodes
   */
  
  /** ACCESSEURS */
  public PVector getDisk(int i){return this.posDisks.get(i);}
  
  /** Dessine le dernier disque ajouté*/
  public void drawLastDisk(){
     int idLastDisk = this.posDisks.size()-1;
     
     float x = this.posDisks.get(idLastDisk).x;
     float y = this.posDisks.get(idLastDisk).y;
     
     ellipse(x,y,this.diameter,this.diameter);
  }
  
  /** Ajoute un disque à l'arbre
   *  @param pos les positions du disque
   */
  public void addDisk(PVector pos){
   this.posDisks.add(pos); 
  }
  
  /**************************************************************************
   * Fonctions de création d'un point A et vérification de sa validité
   */
  
  /** Vérifie si deux points se chevauchent
   *  @param a,b les points
   *  @return true, si les deux points se chevauchent
   *          false, sinon
   */
  private boolean arePointOverlapping(PVector a, PVector b){
    return PVector.dist(a,b) <= this.diameter ;
  }
  
  /** Vérifie si le point A permet d'ajouter un nouveau disque sans collisions
   *  @param A le point a tester
   *  @return true, si le point A ne chevauche aucun disque de l'arbre
   *          false, sinon
   */
  private boolean isValidPoint(PVector A){
    boolean isValid = true;
    int i = 0;
    
    while(i<this.posDisks.size()-1 && isValid){
      isValid = !arePointOverlapping(A,this.posDisks.get(i));
      i++;
    }
    
    return isValid; 
  }
  
  /** Génère un point aléatoire sur la surface
   *  @return la position générée
   */
  private PVector generateRandomPos(){
    /* On fait en sorte qu'un bord de largeur d'un rayon d'un disque ne puisse pas généré de point, 
       cela permet qu'aucun disque ne dépasse de l'écran */
    float x = random(this.diameter/2,width-this.diameter/2);
    float y = random(this.diameter/2,height-this.diameter/2);
    
    return new PVector(x,y);
  }
  
  /** Génère un position aléatoire tel qu'elle ne chevauche aucun disque de l'arbre
   *  @return les positions générées
   */
  public PVector generateValidRandomPos(){
    PVector pos = this.generateRandomPos();
    while(!this.isValidPoint(pos)){
      pos = this.generateRandomPos();
    }
    return pos;
  }
  
  /**************************************************************************
   * Fonctions de génération d'un nouveau disque
   */
  
  /** Recherche du disque le plus proche en terme de coordonnées du point A
   *  @param A une position
   *  @return l'indice du disque le plus proche de A
   */
  private int findCloserDisk(PVector A){
    int id_closer = 0;
    
    for(int i=1 ; i<this.posDisks.size() ; i++){
      PVector closerDisk = this.posDisks.get(id_closer); 
      PVector currentDisk = this.posDisks.get(i);
      boolean isCurrentCloser = PVector.dist(currentDisk,A) < PVector.dist(closerDisk,A);
      
      if(isCurrentCloser){
        id_closer = i;
      }
    }
    
    return id_closer;
  }
  
  /** Génère un nouveau disque sur l'axe de a vers B tel qu'il soit accolé à B 
   *  @param A,B des positions
   */
  private PVector generateNewDiskAToB(PVector A, PVector B){
    float distAtoB = PVector.dist(A,B);
    float percent = this.diameter/distAtoB;
    PVector disk = PVector.lerp(B, A, percent);
    
    return disk;
  }
  
  /** Génère un nouveau disque dans l'arbre tel qu'il respecte les conditions suivantes :
   *    - Un point A est généré aléatoirement sur la fenetre
   *    - On cherche le disque déjà présent dans l'arbre étant le plus proche de A, closerDisk
   *    - On place un nouveau disque sur l'axe de A vers closerDisk, accolé à closerDisk
   */
  public void generateNewDisk(){
    PVector A = this.generateValidRandomPos();
    PVector closerDisk = this.getDisk(this.findCloserDisk(A));
    
    /* A decommenter si l'on souhaite visualisé les vecteurs de A vers closerDisk */
    stroke(0,255,0);
    line(A.x,A.y,closerDisk.x,closerDisk.y);
    
    this.addDisk(this.generateNewDiskAToB(A,closerDisk));
  }
  
}
