//================================================================================
// skBottlePotionBlue.
//================================================================================

class skBottlePotionBlue extends HPMeshActor;

//model import (skBottlePotionBlueMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBottlePotionBlueMesh ModelFile=Models\skBottlePotionBlueMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBottlePotionBlueMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBottlePotionBlueAnims) -AdamJD 
#exec Anim Import Anim=skBottlePotionBlueAnims AnimFile=Models\skBottlePotionBlueAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBottlePotionBlueMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBottlePotionBlueMesh Anim=skBottlePotionBlueAnims
#exec Anim Digest Anim=skBottlePotionBlueAnims VERBOSE 

//texture import (skBottlePotionBlueTex0) -AdamJD 
#exec Texture Import File=Textures\skBottlePotionBlueTex0.png Name=skBottlePotionBlueTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBottlePotionBlueMesh Num=0 Texture=skBottlePotionBlueTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBottlePotionBlueMesh
}
