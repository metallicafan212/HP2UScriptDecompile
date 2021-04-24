//================================================================================
// skDragonHead.
//================================================================================

class skDragonHead extends HPMeshActor;

//model import (skDragonHeadMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skDragonHeadMesh ModelFile=Models\skDragonHeadMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skDragonHeadMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skDragonHeadAnims) -AdamJD 
#exec Anim Import Anim=skDragonHeadAnims AnimFile=Models\skDragonHeadAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skDragonHeadMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skDragonHeadMesh Anim=skDragonHeadAnims
#exec Anim Digest Anim=skDragonHeadAnims VERBOSE 

//texture import (skDragonHeadTex0) -AdamJD 
#exec Texture Import File=Textures\skDragonHeadTex0.png Name=skDragonHeadTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skDragonHeadMesh Num=0 Texture=skDragonHeadTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skDragonHeadMesh
}
