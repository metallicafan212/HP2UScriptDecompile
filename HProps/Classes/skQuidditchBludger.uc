//================================================================================
// skQuidditchBludger.
//================================================================================

class skQuidditchBludger extends HPMeshActor;

//model import (skQuidditchBludgerMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skQuidditchBludgerMesh ModelFile=Models\skQuidditchBludgerMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skQuidditchBludgerMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skQuidditchBludgerAnims) -AdamJD 
#exec Anim Import Anim=skQuidditchBludgerAnims AnimFile=Models\skQuidditchBludgerAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skQuidditchBludgerMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skQuidditchBludgerMesh Anim=skQuidditchBludgerAnims
#exec Anim Digest Anim=skQuidditchBludgerAnims VERBOSE 

//texture import (skQuidditchBludgerTex0) -AdamJD 
#exec Texture Import File=Textures\skQuidditchBludgerTex0.png Name=skQuidditchBludgerTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skQuidditchBludgerMesh Num=0 Texture=skQuidditchBludgerTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skQuidditchBludgerMesh
}
