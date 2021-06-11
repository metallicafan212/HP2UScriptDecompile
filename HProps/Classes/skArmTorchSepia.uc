//================================================================================
// skArmTorchSepia.
//================================================================================

class skArmTorchSepia extends HPMeshActor;

//model import (skArmTorchSepiaMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skArmTorchSepiaMesh ModelFile=Models\skArmTorchSepiaMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skArmTorchSepiaMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skArmTorchSepiaAnims) -AdamJD 
#exec Anim Import Anim=skArmTorchSepiaAnims AnimFile=Models\skArmTorchSepiaAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skArmTorchSepiaMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skArmTorchSepiaMesh Anim=skArmTorchSepiaAnims
#exec Anim Digest Anim=skArmTorchSepiaAnims VERBOSE 

//texture import (skArmTorchSepiaTex0) -AdamJD 
#exec Texture Import File=Textures\skArmTorchSepiaTex0.png Name=skArmTorchSepiaTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skArmTorchSepiaMesh Num=0 Texture=skArmTorchSepiaTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skArmTorchSepiaMesh
}
