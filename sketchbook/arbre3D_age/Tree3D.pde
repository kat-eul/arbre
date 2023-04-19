/*****************************************************************
 * Tree3D.pde
 * Définit un arbre dans un espace 3D contenant une suite de triangles
 * le composant
 * @author Katel HIGNARD
 */

public class Tree3D{
  private ArrayList<Triangle> triangles;
  private float radiusTriangle;
  
  /*****************************************************************
   * CONSTRUCTEUR
   * @param radius le rayon des triangles
   */
  public Tree3D(float radius){
    this.radiusTriangle = radius;
    this.triangles = new ArrayList<Triangle>();
    this.triangles.add(new Triangle(0,0,radius,radius));
  }
  
  /*****************************************************************
   * Méthodes
   */
  
  /** ACCESSEURS */
  Triangle getTriangle(int i){ return this.triangles.get(i);}
  ArrayList<Triangle> getAllTriangle(){return this.triangles;}
  
  /** Dessine l'arbre 
   *  @param youngerColor la couleur des triangles les plus récemment ajoutés
   *  @param agedColor la couleur des triangles les plus anciennement ajoutés
   *  @param percentRadiusMin & percentRadiusMax : 
   *      l'intervalle de pourcentage affectant la taille du triangle
   */
  public void draw(color youngerColor,  color agedColor, float percentRadiusMin, float percentRadiusMax){
    /* Modifications apportées :
     *   - ajouts des paramètres cités ci dessus
     *   - interpolation de couleur et de taille
     */
     
    for(int i=0 ; i<this.triangles.size() ; i++){
      // interpolation de couleur
      color c = lerpColor(agedColor,youngerColor,(float)i/(this.triangles.size()-1));
      fill(c);
      
      // interpolation de la taille
      float percent = lerp(percentRadiusMin,percentRadiusMax,(float)i/(this.triangles.size()-1));
      
      this.triangles.get(i).draw(percent); 
    }
  }
  
  
  
  /*****************************************************************
   * Fonctions de création aléatoire et de vérification d'un point A (x,y,z)
   */
  
  /** @return true, si a et b se superposent
   *          false, sinon
   *  @param a,b des positions 3D 
   */
  private boolean arePointOverlapping(PVector a,PVector b){
   return PVector.dist(a,b) <= this.radiusTriangle*2;
  }
  
  /** Retourne si le point A est assez éloigné de l'ensemble de Triangles
   * @param A, soit des coordonnées x,y,z
   * @return true, si le point A est valide
   *         false,sinon
   */
  private boolean isValidPointA(PVector A){
    boolean isValid = true;
    int i = 0;
    
    while(i<this.triangles.size() && isValid){
      isValid = !tree.arePointOverlapping(A,this.triangles.get(i).getPos());
      i++;
    }
    
    return isValid;
  }
  
  /** @return un point aléatoire dans l'espace 3D */
  private PVector generateRandom3DPos(){
    float x = random(-sizePlatform,sizePlatform);
    float y = random(-sizePlatform,sizePlatform);
    float z = random(this.radiusTriangle,sizePlatform*2);
    return new PVector(x,y,z);
  }
  
  /** @return une point A aléatoire parmis l'espace 3D, tel qu'il
   *          ne soit en superposition avec aucun triangle déjà existants
   */
  public PVector generateValidRandom3DPos(){
    PVector pos = this.generateRandom3DPos();
    while(!this.isValidPointA(pos)){
      pos = this.generateRandom3DPos();
    }
    return pos;
  }
  /*****************************************************************
   * Fonctions de génération d'un nouveau Triangle selon l'emplacement
   * d'un point aléatoire A
   */
  
  /** Génère un triangle sur l'axe de A vers closerTriangle, étant accolé à closerTriangle
   *  @param A un point généré aléatoirement
   *  @param closerTriangle le triangle le plus proche du point A
   */
  public Triangle generateTriangleAToTriangle(PVector A, Triangle triangle){
    float distAtoCloserTriangle = PVector.dist(A,triangle.getPos());
    float percent = this.radiusTriangle/distAtoCloserTriangle;
    PVector newTriangle = PVector.lerp(triangle.getPos(), A, percent);
    
    return new Triangle(newTriangle,this.radiusTriangle);
  }
  
  /** Ajoute le triangle en entrée dans la liste des triangles
   * @param triangle 
   */
  public void addTriangle(Triangle triangle){
    this.triangles.add(triangle);
  }
  
  /** Cherche le triangle le plus proche du point A
   *  @param A un point généré aléatoirement 
   *  @return l'indice du triangle le plus proche de A
   */
  public int findCloserTriangleToA(PVector A){
    int id_closer = 0;
    
    for(int i=1;i<this.triangles.size(); i++){
      PVector closerDisk = this.triangles.get(id_closer).getPos(); 
      PVector currentDisk = this.triangles.get(i).getPos();
      boolean isCurrentCloser = PVector.dist(currentDisk,A) < PVector.dist(closerDisk,A);
      
      if(isCurrentCloser){
        id_closer = i;
      }
    }
    return id_closer;
  }
  
  public void generateNewTriangle(){
   PVector A = this.generateValidRandom3DPos();
   Triangle closerTriangle = this.triangles.get(this.findCloserTriangleToA(A));
   
   this.addTriangle(this.generateTriangleAToTriangle(A,closerTriangle));
   
  }
}
