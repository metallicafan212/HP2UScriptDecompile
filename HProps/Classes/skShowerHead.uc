//================================================================================
// skShowerHead.
//================================================================================

class skShowerHead extends HPMeshActor;

//model import (skShowerHeadMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skShowerHeadMesh ModelFile=Models\skShowerHeadMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skShowerHeadMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skShowerHeadAnims) -AdamJD 
#exec Anim Import Anim=skShowerHeadAnims AnimFile=Models\skShowerHeadAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skShowerHeadMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skShowerHeadMesh Anim=skShowerHeadAnims
#exec Anim Digest Anim=skShowerHeadAnims VERBOSE 

//texture import (skShowerHeadTex0) -AdamJD 
#exec Texture Import File=Textures\skShowerHeadTex0.png Name=skShowerHeadTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skShowerHeadMesh Num=0 Texture=skShowerHeadTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skShowerHeadMesh
}
