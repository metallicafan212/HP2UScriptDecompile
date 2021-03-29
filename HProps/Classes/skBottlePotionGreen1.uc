//================================================================================
// skBottlePotionGreen1.
//================================================================================

class skBottlePotionGreen1 extends HPMeshActor;

//model import (skBottlePotionGreen1Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBottlePotionGreen1Mesh ModelFile=Models\skBottlePotionGreen1Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBottlePotionGreen1Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBottlePotionGreen1Anims) -AdamJD 
#exec Anim Import Anim=skBottlePotionGreen1Anims AnimFile=Models\skBottlePotionGreen1Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBottlePotionGreen1Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBottlePotionGreen1Mesh Anim=skBottlePotionGreen1Anims
#exec Anim Digest Anim=skBottlePotionGreen1Anims VERBOSE 

//texture import (skBottlePotionGreen1Tex0) -AdamJD 
#exec Texture Import File=Textures\skBottlePotionGreen1Tex0.png Name=skBottlePotionGreen1Tex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBottlePotionGreen1Mesh Num=0 Texture=skBottlePotionGreen1Tex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBottlePotionGreen1Mesh
}
