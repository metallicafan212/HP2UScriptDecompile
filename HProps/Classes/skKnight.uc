//================================================================================
// skKnight.
//================================================================================

class skKnight extends HPMeshActor;

//model import (skKnightMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skKnightMesh ModelFile=Models\skKnightMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skKnightMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skKnightAnims) -AdamJD 
#exec Anim Import Anim=skKnightAnims AnimFile=Models\skKnightAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skKnightMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skKnightMesh Anim=skKnightAnims
#exec Anim Digest Anim=skKnightAnims VERBOSE 

//texture import (skKnightTex0) -AdamJD 
#exec Texture Import File=Textures\skKnightTex0.png Name=skKnightTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skKnightMesh Num=0 Texture=skKnightTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skKnightMesh
}
