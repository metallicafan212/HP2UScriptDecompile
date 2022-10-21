//================================================================================
// skDishesHagridTeaPot.
//================================================================================

class skDishesHagridTeaPot extends HPMeshActor;

//model import (skDishesHagridTeaPotMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skDishesHagridTeaPotMesh ModelFile=Models\skDishesHagridTeaPotMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skDishesHagridTeaPotMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skDishesHagridTeaPotAnims) -AdamJD 
#exec Anim Import Anim=skDishesHagridTeaPotAnims AnimFile=Models\skDishesHagridTeaPotAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skDishesHagridTeaPotMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skDishesHagridTeaPotMesh Anim=skDishesHagridTeaPotAnims
#exec Anim Digest Anim=skDishesHagridTeaPotAnims VERBOSE 

//texture import (skDishesHagridTeaPotTex0) -AdamJD 
#exec Texture Import File=Textures\skDishesHagridTeaPotTex0.png Name=skDishesHagridTeaPotTex0 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 MaskedOverride=(R=0,G=0,B=0,A=255) Group=Skins 
#exec MeshMap SetTexture MeshMap=skDishesHagridTeaPotMesh Num=0 Texture=skDishesHagridTeaPotTex0

//texture import (skDishesHagridTeaPotTex1) -AdamJD 
#exec Texture Import File=Textures\skDishesHagridTeaPotTex1.png Name=skDishesHagridTeaPotTex1 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 MaskedOverride=(R=0,G=0,B=0,A=255) Group=Skins 
#exec MeshMap SetTexture MeshMap=skDishesHagridTeaPotMesh Num=1 Texture=skDishesHagridTeaPotTex1

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skDishesHagridTeaPotMesh
}
