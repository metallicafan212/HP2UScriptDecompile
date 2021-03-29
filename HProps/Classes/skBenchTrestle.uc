//================================================================================
// skBenchTrestle.
//================================================================================

class skBenchTrestle extends HPMeshActor;

//model import (skBenchTrestleMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBenchTrestleMesh ModelFile=Models\skBenchTrestleMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBenchTrestleMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBenchTrestleAnims) -AdamJD 
#exec Anim Import Anim=skBenchTrestleAnims AnimFile=Models\skBenchTrestleAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBenchTrestleMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBenchTrestleMesh Anim=skBenchTrestleAnims
#exec Anim Digest Anim=skBenchTrestleAnims VERBOSE 

//texture import (skBenchTrestleTex0) -AdamJD 
#exec Texture Import File=Textures\skBenchTrestleTex0.png Name=skBenchTrestleTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBenchTrestleMesh Num=0 Texture=skBenchTrestleTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBenchTrestleMesh
}
