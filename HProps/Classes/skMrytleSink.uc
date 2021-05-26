//================================================================================
// skMrytleSink.
//================================================================================

class skMrytleSink extends HPMeshActor;

//model import (skMrytleSinkMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skMrytleSinkMesh ModelFile=Models\skMrytleSinkMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skMrytleSinkMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skMrytleSinkAnims) -AdamJD 
#exec Anim Import Anim=skMrytleSinkAnims AnimFile=Models\skMrytleSinkAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skMrytleSinkMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skMrytleSinkMesh Anim=skMrytleSinkAnims
#exec Anim Digest Anim=skMrytleSinkAnims VERBOSE 

//texture import (skMrytleSinkTex0) -AdamJD 
#exec Texture Import File=Textures\skMrytleSinkTex0.png Name=skMrytleSinkTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skMrytleSinkMesh Num=0 Texture=skMrytleSinkTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skMrytleSinkMesh
}
