//================================================================================
// skhanginglampGS.
//================================================================================

class skhanginglampGS extends HPMeshActor;

//model import (skhanginglampGSMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skhanginglampGSMesh ModelFile=Models\skhanginglampGSMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skhanginglampGSMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skhanginglampGSAnims) -AdamJD 
#exec Anim Import Anim=skhanginglampGSAnims AnimFile=Models\skhanginglampGSAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skhanginglampGSMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skhanginglampGSMesh Anim=skhanginglampGSAnims
#exec Anim Digest Anim=skhanginglampGSAnims VERBOSE 

//texture import (skhanginglampGSTex0) -AdamJD 
#exec Texture Import File=Textures\skhanginglampGSTex0.png Name=skhanginglampGSTex0 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 MaskedOverride=(R=0,G=0,B=0,A=255) Group=Skins 
#exec MeshMap SetTexture MeshMap=skhanginglampGSMesh Num=0 Texture=skhanginglampGSTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skhanginglampGSMesh
}
