//================================================================================
// skBedInfirmary.
//================================================================================

class skBedInfirmary extends HPMeshActor;

//model import (skBedInfirmaryMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBedInfirmaryMesh ModelFile=Models\skBedInfirmaryMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBedInfirmaryMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBedInfirmaryAnims) -AdamJD 
#exec Anim Import Anim=skBedInfirmaryAnims AnimFile=Models\skBedInfirmaryAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBedInfirmaryMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBedInfirmaryMesh Anim=skBedInfirmaryAnims
#exec Anim Digest Anim=skBedInfirmaryAnims VERBOSE 

//texture import (skBedInfirmaryTex0) -AdamJD 
#exec Texture Import File=Textures\skBedInfirmaryTex0.png Name=skBedInfirmaryTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBedInfirmaryMesh Num=0 Texture=skBedInfirmaryTex0

//texture import (skBedInfirmaryTex1) -AdamJD 
#exec Texture Import File=Textures\skBedInfirmaryTex1.png Name=skBedInfirmaryTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBedInfirmaryMesh Num=1 Texture=skBedInfirmaryTex1

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBedInfirmaryMesh
}
