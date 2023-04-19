/*****************************************************************
 * Triangle.pde
 * Définit un triangle, avec ses positions dans un espace 3D
 * et son rayon
 * @author Katel HIGNARD
 */
 
public class Triangle{
  private PVector pos;
  private float cellRadius;
  private float angleRotation;
  
  /***************************************************************** 
   * Contructeurs
   *  @param pos La position (x,y,z) du triangle
   *      ou x,y,z 
   *  @param radius le rayon du triangle
   *  post-condition: La valeur de l'axe z doit être telle que le triangle ne traversera pas
   *                  la platerforme a l'affichage    
   */
  Triangle(PVector pos, float radius){
   this.pos = pos;
   this.cellRadius = radius;
   this.angleRotation = 0;
   
   if(this.pos.z<this.cellRadius){
    this.pos.z = this.cellRadius; 
   }
  }
  
  public Triangle(float x, float y, float z, float radius){
    if(z<radius){
     z = radius; 
    }
    this.pos = new PVector(x,y,z);
    this.cellRadius = radius;
    this.angleRotation = 0;
  }
  
  /***************************************************************** 
   * Méthodes
   */
   
  /** ACCESSEURS */
  public PVector getPos(){return this.pos;}
  public float getX(){return this.pos.x;}
  public float getY(){return this.pos.y;}
  public float getZ(){return this.pos.z;}
  
  /** Dessine le triangle */
  public void draw(){
    pushMatrix();
    
    translate(this.pos.x,this.pos.y,this.pos.z);
    rotateX(this.angleRotation);
    rotateY(this.angleRotation);
    rotateZ(this.angleRotation);
    
    beginShape();
    vertex(-this.cellRadius,-this.cellRadius,0);
    vertex(-this.cellRadius,this.cellRadius,0);
    vertex(this.cellRadius,this.cellRadius,0);
    endShape();
    
    popMatrix();
    
    // Modification de l'angle de rotation pour le prochain affichage
    this.angleRotation += PI/72;
  }
}
