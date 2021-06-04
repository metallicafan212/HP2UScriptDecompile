//================================================================================
// skPadlock.
//================================================================================

class skPadlock extends HPMeshActor;

//model import (skPadlockMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skPadlockMesh ModelFile=Models\skPadlockMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skPadlockMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skPadlockAnims) -AdamJD 
#exec Anim Import Anim=skPadlockAnims AnimFile=Models\skPadlockAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skPadlockMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skPadlockMesh Anim=skPadlockAnims
#exec Anim Digest Anim=skPadlockAnims VERBOSE 

//texture import (skPadlockTex0) -AdamJD 
#exec Texture Import File=Textures\skPadlockTex0.png Name=skPadlockTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skPadlockMesh Num=0 Texture=skPadlockTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skPadlockMesh
}
