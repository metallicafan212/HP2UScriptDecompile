//================================================================================
// skBottlePotionPurple.
//================================================================================

class skBottlePotionPurple extends HPMeshActor;

//model import (skBottlePotionPurpleMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBottlePotionPurpleMesh ModelFile=Models\skBottlePotionPurpleMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBottlePotionPurpleMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBottlePotionPurpleAnims) -AdamJD 
#exec Anim Import Anim=skBottlePotionPurpleAnims AnimFile=Models\skBottlePotionPurpleAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBottlePotionPurpleMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBottlePotionPurpleMesh Anim=skBottlePotionPurpleAnims
#exec Anim Digest Anim=skBottlePotionPurpleAnims VERBOSE 

//texture import (skBottlePotionPurpleTex0) -AdamJD 
#exec Texture Import File=Textures\skBottlePotionPurpleTex0.png Name=skBottlePotionPurpleTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBottlePotionPurpleMesh Num=0 Texture=skBottlePotionPurpleTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBottlePotionPurpleMesh
}
