//================================================================================
// skBooksBigFlitwickBook.
//================================================================================

class skBooksBigFlitwickBook extends HPMeshActor;

//model import (skBooksBigFlitwickBookMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBooksBigFlitwickBookMesh ModelFile=Models\skBooksBigFlitwickBookMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBooksBigFlitwickBookMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBooksBigFlitwickBookAnims) -AdamJD 
#exec Anim Import Anim=skBooksBigFlitwickBookAnims AnimFile=Models\skBooksBigFlitwickBookAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBooksBigFlitwickBookMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBooksBigFlitwickBookMesh Anim=skBooksBigFlitwickBookAnims
#exec Anim Digest Anim=skBooksBigFlitwickBookAnims VERBOSE 

//texture import (skBooksBigFlitwickBookTex0) -AdamJD 
#exec Texture Import File=Textures\skBooksBigFlitwickBookTex0.png Name=skBooksBigFlitwickBookTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBooksBigFlitwickBookMesh Num=0 Texture=skBooksBigFlitwickBookTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBooksBigFlitwickBookMesh
}
