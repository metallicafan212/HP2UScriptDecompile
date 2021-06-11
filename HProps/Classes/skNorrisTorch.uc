//================================================================================
// skNorrisTorch.
//================================================================================

class skNorrisTorch extends HPMeshActor;

//model import (skNorrisTorchMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skNorrisTorchMesh ModelFile=Models\skNorrisTorchMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skNorrisTorchMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skNorrisTorchAnims) -AdamJD 
#exec Anim Import Anim=skNorrisTorchAnims AnimFile=Models\skNorrisTorchAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skNorrisTorchMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skNorrisTorchMesh Anim=skNorrisTorchAnims
#exec Anim Digest Anim=skNorrisTorchAnims VERBOSE 

//texture import (skNorrisTorchTex0) -AdamJD 
#exec Texture Import File=Textures\skNorrisTorchTex0.png Name=skNorrisTorchTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skNorrisTorchMesh Num=0 Texture=skNorrisTorchTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skNorrisTorchMesh
}
