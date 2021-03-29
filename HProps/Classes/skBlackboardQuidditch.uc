//================================================================================
// skBlackboardQuidditch.
//================================================================================

class skBlackboardQuidditch extends HPMeshActor;

//model import (skBlackboardQuidditchMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBlackboardQuidditchMesh ModelFile=Models\skBlackboardQuidditchMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBlackboardQuidditchMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBlackboardQuidditchAnims) -AdamJD 
#exec Anim Import Anim=skBlackboardQuidditchAnims AnimFile=Models\skBlackboardQuidditchAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBlackboardQuidditchMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBlackboardQuidditchMesh Anim=skBlackboardQuidditchAnims
#exec Anim Digest Anim=skBlackboardQuidditchAnims VERBOSE 

//texture import (skBlackboardQuidditchTex0) -AdamJD 
#exec Texture Import File=Textures\skBlackboardQuidditchTex0.png Name=skBlackboardQuidditchTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBlackboardQuidditchMesh Num=0 Texture=skBlackboardQuidditchTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBlackboardQuidditchMesh
}
