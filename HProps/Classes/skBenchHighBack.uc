//================================================================================
// skBenchHighBack.
//================================================================================

class skBenchHighBack extends HPMeshActor;

//model import (skBenchHighBackMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBenchHighBackMesh ModelFile=Models\skBenchHighBackMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBenchHighBackMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBenchHighBackAnims) -AdamJD 
#exec Anim Import Anim=skBenchHighBackAnims AnimFile=Models\skBenchHighBackAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBenchHighBackMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBenchHighBackMesh Anim=skBenchHighBackAnims
#exec Anim Digest Anim=skBenchHighBackAnims VERBOSE

//texture import (skBenchHighBackTex0) -AdamJD 
#exec Texture Import File=Textures\skBenchHighBackTex0.png Name=skBenchHighBackTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBenchHighBackMesh Num=0 Texture=skBenchHighBackTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBenchHighBackMesh
}
