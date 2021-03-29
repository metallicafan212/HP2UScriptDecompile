//================================================================================
// skBottlePotionOrange.
//================================================================================

class skBottlePotionOrange extends HPMeshActor;

//model import (skBottlePotionOrangeMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBottlePotionOrangeMesh ModelFile=Models\skBottlePotionOrangeMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBottlePotionOrangeMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBottlePotionOrangeAnims) -AdamJD 
#exec Anim Import Anim=skBottlePotionOrangeAnims AnimFile=Models\skBottlePotionOrangeAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBottlePotionOrangeMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBottlePotionOrangeMesh Anim=skBottlePotionOrangeAnims
#exec Anim Digest Anim=skBottlePotionOrangeAnims VERBOSE 

//texture import (skBottlePotionOrangeTex0) -AdamJD 
#exec Texture Import File=Textures\skBottlePotionOrangeTex0.png Name=skBottlePotionOrangeTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBottlePotionOrangeMesh Num=0 Texture=skBottlePotionOrangeTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBottlePotionOrangeMesh
}
