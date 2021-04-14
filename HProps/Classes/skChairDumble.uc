//================================================================================
// skChairDumble.
//================================================================================

class skChairDumble extends HPMeshActor;

//model import (skChairDumbleMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skChairDumbleMesh ModelFile=Models\skChairDumbleMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skChairDumbleMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0

//anim import (skChairDumbleAnims) -AdamJD 
#exec Anim Import Anim=skChairDumbleAnims AnimFile=Models\skChairDumbleAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skChairDumbleMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skChairDumbleMesh Anim=skChairDumbleAnims
#exec Anim Digest Anim=skChairDumbleAnims VERBOSE 

//texture import (skChairDumbleTex0) -AdamJD 
#exec Texture Import File=Textures\skChairDumbleTex0.png Name=skChairDumbleTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skChairDumbleMesh Num=0 Texture=skChairDumbleTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skChairDumbleMesh
}
