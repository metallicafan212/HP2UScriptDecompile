//================================================================================
// skBooksPeevesThrow.
//================================================================================

class skBooksPeevesThrow extends HPMeshActor;

//model import (skBooksPeevesThrowMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBooksPeevesThrowMesh ModelFile=Models\skBooksPeevesThrowMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBooksPeevesThrowMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBooksPeevesThrowAnims) -AdamJD 
#exec Anim Import Anim=skBooksPeevesThrowAnims AnimFile=Models\skBooksPeevesThrowAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBooksPeevesThrowMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBooksPeevesThrowMesh Anim=skBooksPeevesThrowAnims
#exec Anim Digest Anim=skBooksPeevesThrowAnims VERBOSE 

//texture import (skBooksPeevesThrowTex0) -AdamJD 
#exec Texture Import File=Textures\skBooksPeevesThrowTex0.png Name=skBooksPeevesThrowTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBooksPeevesThrowMesh Num=0 Texture=skBooksPeevesThrowTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBooksPeevesThrowMesh
}
