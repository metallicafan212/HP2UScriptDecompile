//================================================================================
// skBenchTable.
//================================================================================

class skBenchTable extends HPMeshActor;

//model import (skBenchTableMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBenchTableMesh ModelFile=Models\skBenchTableMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBenchTableMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBenchTableAnims) -AdamJD 
#exec Anim Import Anim=skBenchTableAnims AnimFile=Models\skBenchTableAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBenchTableMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBenchTableMesh Anim=skBenchTableAnims
#exec Anim Digest Anim=skBenchTableAnims VERBOSE 

//texture import (skBenchTableTex0) -AdamJD 
#exec Texture Import File=Textures\skBenchTableTex0.png Name=skBenchTableTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBenchTableMesh Num=0 Texture=skBenchTableTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBenchTableMesh
}
