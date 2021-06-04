//================================================================================
// skRedBlackStripeBean.
//================================================================================

class skRedBlackStripeBean extends HPMeshActor;

//model import (skRedBlackStripeBeanMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skRedBlackStripeBeanMesh ModelFile=Models\skRedBlackStripeBeanMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skRedBlackStripeBeanMesh X=0 Y=0 Z=16 Yaw=0 Pitch=0 Roll=0 

//anim import (skRedBlackStripeBeanAnims) -AdamJD 
#exec Anim Import Anim=skRedBlackStripeBeanAnims AnimFile=Models\skRedBlackStripeBeanAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skRedBlackStripeBeanMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skRedBlackStripeBeanMesh Anim=skRedBlackStripeBeanAnims
#exec Anim Digest Anim=skRedBlackStripeBeanAnims VERBOSE 

//texture import (skRedBlackStripeBeanTex0) -AdamJD 
#exec Texture Import File=Textures\skRedBlackStripeBeanTex0.png Name=skRedBlackStripeBeanTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skRedBlackStripeBeanMesh Num=0 Texture=skRedBlackStripeBeanTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skRedBlackStripeBeanMesh
}
