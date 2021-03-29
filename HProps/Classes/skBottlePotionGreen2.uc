//================================================================================
// skBottlePotionGreen2.
//================================================================================

class skBottlePotionGreen2 extends HPMeshActor;

//model import (skBottlePotionGreen2Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBottlePotionGreen2Mesh ModelFile=Models\skBottlePotionGreen2Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBottlePotionGreen2Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBottlePotionGreen2Anims) -AdamJD 
#exec Anim Import Anim=skBottlePotionGreen2Anims AnimFile=Models\skBottlePotionGreen2Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBottlePotionGreen2Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBottlePotionGreen2Mesh Anim=skBottlePotionGreen2Anims
#exec Anim Digest Anim=skBottlePotionGreen2Anims VERBOSE 

//texture import (skBottlePotionGreen2Tex0) -AdamJD 
#exec Texture Import File=Textures\skBottlePotionGreen2Tex0.png Name=skBottlePotionGreen2Tex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBottlePotionGreen2Mesh Num=0 Texture=skBottlePotionGreen2Tex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBottlePotionGreen2Mesh
}
