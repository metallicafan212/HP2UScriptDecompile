//================================================================================
// skDeskStudent1.
//================================================================================

class skDeskStudent1 extends HPMeshActor;

//model import (skDeskStudent1Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skDeskStudent1Mesh ModelFile=Models\skDeskStudent1Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skDeskStudent1Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skDeskStudent1Anims) -AdamJD 
#exec Anim Import Anim=skDeskStudent1Anims AnimFile=Models\skDeskStudent1Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skDeskStudent1Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skDeskStudent1Mesh Anim=skDeskStudent1Anims
#exec Anim Digest Anim=skDeskStudent1Anims VERBOSE 

//texture import (skDeskStudent1Tex0) -AdamJD 
#exec Texture Import File=Textures\skDeskStudent1Tex0.png Name=skDeskStudent1Tex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skDeskStudent1Mesh Num=0 Texture=skDeskStudent1Tex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skDeskStudent1Mesh
}
