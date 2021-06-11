//================================================================================
// skwaterpuddle.
//================================================================================

class skwaterpuddle extends HPMeshActor;

//model import (skwaterpuddleMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skwaterpuddleMesh ModelFile=Models\skwaterpuddleMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skwaterpuddleMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skwaterpuddleAnims) -AdamJD 
#exec Anim Import Anim=skwaterpuddleAnims AnimFile=Models\skwaterpuddleAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skwaterpuddleMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skwaterpuddleMesh Anim=skwaterpuddleAnims
#exec Anim Digest Anim=skwaterpuddleAnims VERBOSE 

//texture import (skwaterpuddleTex0) -AdamJD 
#exec Texture Import File=Textures\skwaterpuddleTex0.png Name=skwaterpuddleTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skwaterpuddleMesh Num=0 Texture=skwaterpuddleTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skwaterpuddleMesh
}
