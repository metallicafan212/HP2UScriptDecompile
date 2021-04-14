//================================================================================
// skCabinetInfirmary.
//================================================================================

class skCabinetInfirmary extends HPMeshActor;

//model import (skCabinetInfirmaryMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skCabinetInfirmaryMesh ModelFile=Models\skCabinetInfirmaryMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skCabinetInfirmaryMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skCabinetInfirmaryAnims) -AdamJD 
#exec Anim Import Anim=skCabinetInfirmaryAnims AnimFile=Models\skCabinetInfirmaryAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skCabinetInfirmaryMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skCabinetInfirmaryMesh Anim=skCabinetInfirmaryAnims
#exec Anim Digest Anim=skCabinetInfirmaryAnims VERBOSE 

//texture import (skCabinetInfirmaryTex0) -AdamJD 
#exec Texture Import File=Textures\skCabinetInfirmaryTex0.png Name=skCabinetInfirmaryTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skCabinetInfirmaryMesh Num=0 Texture=skCabinetInfirmaryTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skCabinetInfirmaryMesh
}
