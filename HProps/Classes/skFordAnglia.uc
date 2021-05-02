//================================================================================
// skFordAnglia.
//================================================================================

class skFordAnglia extends HPMeshActor;

//model import (skFordAngliaMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skFordAngliaMesh ModelFile=Models\skFordAngliaMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skFordAngliaMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skFordAngliaAnims) -AdamJD 
#exec Anim Import Anim=skFordAngliaAnims AnimFile=Models\skFordAngliaAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skFordAngliaMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skFordAngliaMesh Anim=skFordAngliaAnims
#exec Anim Digest Anim=skFordAngliaAnims VERBOSE 

//texture import (skFordAngliaTex0) -AdamJD 
#exec Texture Import File=Textures\skFordAngliaTex0.png Name=skFordAngliaTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFordAngliaMesh Num=0 Texture=skFordAngliaTex0

//texture import (skFordAngliaTex1) -AdamJD 
#exec Texture Import File=Textures\skFordAngliaTex1.png Name=skFordAngliaTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFordAngliaMesh Num=1 Texture=skFordAngliaTex1

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skFordAngliaMesh
}
