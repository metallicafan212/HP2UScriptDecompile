//================================================================================
// skLadder.
//================================================================================

class skLadder extends HPMeshActor;

//model import (skLadderMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skLadderMesh ModelFile=Models\skLadderMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skLadderMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skLadderAnims) -AdamJD 
#exec Anim Import Anim=skLadderAnims AnimFile=Models\skLadderAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skLadderMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skLadderMesh Anim=skLadderAnims
#exec Anim Digest Anim=skLadderAnims VERBOSE 

//texture import (skLadderTex0) -AdamJD 
#exec Texture Import File=Textures\skLadderTex0.png Name=skLadderTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skLadderMesh Num=0 Texture=skLadderTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skLadderMesh
}
