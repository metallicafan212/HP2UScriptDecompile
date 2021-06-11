//================================================================================
// skArmTorch.
//================================================================================

class skArmTorch extends HPMeshActor;

//model import (skArmTorchMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skArmTorchMesh ModelFile=Models\skArmTorchMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skArmTorchMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skArmTorchAnims) -AdamJD 
#exec Anim Import Anim=skArmTorchAnims AnimFile=Models\skArmTorchAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skArmTorchMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skArmTorchMesh Anim=skArmTorchAnims
#exec Anim Digest Anim=skArmTorchAnims VERBOSE 

//texture import (skArmTorchTex0) -AdamJD 
#exec Texture Import File=Textures\skArmTorchTex0.png Name=skArmTorchTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=2 Group=Skins
#exec MeshMap SetTexture MeshMap=skArmTorchMesh Num=0 Texture=skArmTorchTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skArmTorchMesh
}
