//================================================================================
// skRope.
//================================================================================

class skRope extends HPMeshActor;

//model import (skRopeMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skRopeMesh ModelFile=Models\skRopeMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skRopeMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skRopeAnims) -AdamJD 
#exec Anim Import Anim=skRopeAnims AnimFile=Models\skRopeAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skRopeMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skRopeMesh Anim=skRopeAnims
#exec Anim Digest Anim=skRopeAnims VERBOSE 

//texture import (skRopeTex0) -AdamJD 
#exec Texture Import File=Textures\skRopeTex0.png Name=skRopeTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skRopeMesh Num=0 Texture=skRopeTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skRopeMesh
}
