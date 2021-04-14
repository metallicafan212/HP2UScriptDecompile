//================================================================================
// skCabinetSupplyCase.
//================================================================================

class skCabinetSupplyCase extends HPMeshActor;

//model import (skCabinetSupplyCaseMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skCabinetSupplyCaseMesh ModelFile=Models\skCabinetSupplyCaseMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skCabinetSupplyCaseMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skCabinetSupplyCaseAnims) -AdamJD 
#exec Anim Import Anim=skCabinetSupplyCaseAnims AnimFile=Models\skCabinetSupplyCaseAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skCabinetSupplyCaseMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skCabinetSupplyCaseMesh Anim=skCabinetSupplyCaseAnims
#exec Anim Digest Anim=skCabinetSupplyCaseAnims VERBOSE 

//texture import (skCabinetSupplyCaseTex0) -AdamJD 
#exec Texture Import File=Textures\skCabinetSupplyCaseTex0.png Name=skCabinetSupplyCaseTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skCabinetSupplyCaseMesh Num=0 Texture=skCabinetSupplyCaseTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skCabinetSupplyCaseMesh
}
