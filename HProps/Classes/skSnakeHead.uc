//================================================================================
// skSnakeHead.
//================================================================================

class skSnakeHead extends HPMeshActor;

//model import (skSnakeHeadMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skSnakeHeadMesh ModelFile=Models\skSnakeHeadMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skSnakeHeadMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skSnakeHeadAnims) -AdamJD 
#exec Anim Import Anim=skSnakeHeadAnims AnimFile=Models\skSnakeHeadAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skSnakeHeadMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skSnakeHeadMesh Anim=skSnakeHeadAnims
#exec Anim Digest Anim=skSnakeHeadAnims VERBOSE 

//texture import (skSnakeHeadTex0) -AdamJD 
#exec Texture Import File=Textures\skSnakeHeadTex0.png Name=skSnakeHeadTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skSnakeHeadMesh Num=0 Texture=skSnakeHeadTex0

//texture import (skSnakeHeadTex1) -AdamJD 
#exec Texture Import File=Textures\skSnakeHeadTex1.png Name=skSnakeHeadTex1 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skSnakeHeadMesh Num=1 Texture=skSnakeHeadTex1

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skSnakeHeadMesh
}
