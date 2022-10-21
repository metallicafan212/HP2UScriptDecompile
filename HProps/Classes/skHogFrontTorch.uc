//================================================================================
// skHogFrontTorch.
//================================================================================

class skHogFrontTorch extends HPMeshActor;

//model import (skHogFrontTorchMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skHogFrontTorchMesh ModelFile=Models\skHogFrontTorchMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skHogFrontTorchMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skHogFrontTorchAnims) -AdamJD 
#exec Anim Import Anim=skHogFrontTorchAnims AnimFile=Models\skHogFrontTorchAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skHogFrontTorchMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skHogFrontTorchMesh Anim=skHogFrontTorchAnims
#exec Anim Digest Anim=skHogFrontTorchAnims VERBOSE 

//texture import (skHogFrontTorchTex0) -AdamJD 
#exec Texture Import File=Textures\skHogFrontTorchTex0.png Name=skHogFrontTorchTex0 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHogFrontTorchMesh Num=0 Texture=skHogFrontTorchTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skHogFrontTorchMesh
}
