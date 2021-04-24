//================================================================================
// skDeskDumble.
//================================================================================

class skDeskDumble extends HPMeshActor;

//model import (skDeskDumbleMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skDeskDumbleMesh ModelFile=Models\skDeskDumbleMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skDeskDumbleMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skDeskDumbleAnims) -AdamJD 
#exec Anim Import Anim=skDeskDumbleAnims AnimFile=Models\skDeskDumbleAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skDeskDumbleMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skDeskDumbleMesh Anim=skDeskDumbleAnims
#exec Anim Digest Anim=skDeskDumbleAnims VERBOSE 

//texture import (skDeskDumbleTex0) -AdamJD 
#exec Texture Import File=Textures\skDeskDumbleTex0.png Name=skDeskDumbleTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skDeskDumbleMesh Num=0 Texture=skDeskDumbleTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skDeskDumbleMesh
}
