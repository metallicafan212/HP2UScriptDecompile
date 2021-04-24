//================================================================================
// skDishesHagridTeaCup.
//================================================================================

class skDishesHagridTeaCup extends HPMeshActor;

//model import (skDishesHagridTeaCupMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skDishesHagridTeaCupMesh ModelFile=Models\skDishesHagridTeaCupMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skDishesHagridTeaCupMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skDishesHagridTeaCupAnims) -AdamJD 
#exec Anim Import Anim=skDishesHagridTeaCupAnims AnimFile=Models\skDishesHagridTeaCupAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skDishesHagridTeaCupMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skDishesHagridTeaCupMesh Anim=skDishesHagridTeaCupAnims
#exec Anim Digest Anim=skDishesHagridTeaCupAnims VERBOSE 

//texture import (skDishesHagridTeaCupTex0) -AdamJD 
#exec Texture Import File=Textures\skDishesHagridTeaCupTex0.png Name=skDishesHagridTeaCupTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skDishesHagridTeaCupMesh Num=0 Texture=skDishesHagridTeaCupTex0

//texture import (skDishesHagridTeaCupTex1) -AdamJD 
#exec Texture Import File=Textures\skDishesHagridTeaCupTex1.png Name=skDishesHagridTeaCupTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skDishesHagridTeaCupMesh Num=1 Texture=skDishesHagridTeaCupTex1

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skDishesHagridTeaCupMesh
}
