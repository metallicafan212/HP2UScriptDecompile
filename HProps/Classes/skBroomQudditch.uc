//================================================================================
// skBroomQudditch.
//================================================================================

class skBroomQudditch extends HPMeshActor;

//model import (skBroomQudditchMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBroomQudditchMesh ModelFile=Models\skBroomQudditchMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBroomQudditchMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBroomQudditchAnims) -AdamJD 
#exec Anim Import Anim=skBroomQudditchAnims AnimFile=Models\skBroomQudditchAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBroomQudditchMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBroomQudditchMesh Anim=skBroomQudditchAnims
#exec Anim Digest Anim=skBroomQudditchAnims VERBOSE 

//texture import (skBroomQudditchTex0) -AdamJD 
#exec Texture Import File=Textures\skBroomQudditchTex0.png Name=skBroomQudditchTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBroomQudditchMesh Num=0 Texture=skBroomQudditchTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBroomQudditchMesh
}
