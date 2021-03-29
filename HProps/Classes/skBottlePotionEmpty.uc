//================================================================================
// skBottlePotionEmpty.
//================================================================================

class skBottlePotionEmpty extends HPMeshActor;

//model import (skBottlePotionEmptyMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBottlePotionEmptyMesh ModelFile=Models\skBottlePotionEmptyMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBottlePotionEmptyMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBottlePotionEmptyAnims) -AdamJD 
#exec Anim Import Anim=skBottlePotionEmptyAnims AnimFile=Models\skBottlePotionEmptyAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBottlePotionEmptyMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBottlePotionEmptyMesh Anim=skBottlePotionEmptyAnims
#exec Anim Digest Anim=skBottlePotionEmptyAnims VERBOSE 

//texture import (skBottlePotionEmptyTex0) -AdamJD 
#exec Texture Import File=Textures\skBottlePotionEmptyTex0.png Name=skBottlePotionEmptyTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBottlePotionEmptyMesh Num=0 Texture=skBottlePotionEmptyTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBottlePotionEmptyMesh
}
