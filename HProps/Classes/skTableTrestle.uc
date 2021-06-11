//================================================================================
// skTableTrestle.
//================================================================================

class skTableTrestle extends HPMeshActor;

//model import (skTableTrestleMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skTableTrestleMesh ModelFile=Models\skTableTrestleMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skTableTrestleMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skTableTrestleAnims) -AdamJD 
#exec Anim Import Anim=skTableTrestleAnims AnimFile=Models\skTableTrestleAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skTableTrestleMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skTableTrestleMesh Anim=skTableTrestleAnims
#exec Anim Digest Anim=skTableTrestleAnims VERBOSE 

//texture import (skTableTrestleTex0) -AdamJD 
#exec Texture Import File=Textures\skTableTrestleTex0.png Name=skTableTrestleTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skTableTrestleMesh Num=0 Texture=skTableTrestleTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skTableTrestleMesh
}
