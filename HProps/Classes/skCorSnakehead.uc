//================================================================================
// skCorSnakehead.
//================================================================================

class skCorSnakehead extends HPMeshActor;

//model import (skCorSnakeheadMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skCorSnakeheadMesh ModelFile=Models\skCorSnakeheadMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skCorSnakeheadMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skCorSnakeheadAnims) -AdamJD 
#exec Anim Import Anim=skCorSnakeheadAnims AnimFile=Models\skCorSnakeheadAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skCorSnakeheadMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skCorSnakeheadMesh Anim=skCorSnakeheadAnims
#exec Anim Digest Anim=skCorSnakeheadAnims VERBOSE 

//texture import (skCorSnakeheadTex0) -AdamJD 
#exec Texture Import File=Textures\skCorSnakeheadTex0.png Name=skCorSnakeheadTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skCorSnakeheadMesh Num=0 Texture=skCorSnakeheadTex0

//texture import (skCorSnakeheadTex1) -AdamJD 
#exec Texture Import File=Textures\skCorSnakeheadTex1.png Name=skCorSnakeheadTex1 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skCorSnakeheadMesh Num=1 Texture=skCorSnakeheadTex1

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skCorSnakeheadMesh
}
