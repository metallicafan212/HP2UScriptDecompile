//================================================================================
// skCauldronSmall.
//================================================================================

class skCauldronSmall extends HPMeshActor;

//model import (skCauldronSmallMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skCauldronSmallMesh ModelFile=Models\skCauldronSmallMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skCauldronSmallMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skCauldronSmallAnims) -AdamJD 
#exec Anim Import Anim=skCauldronSmallAnims AnimFile=Models\skCauldronSmallAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skCauldronSmallMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skCauldronSmallMesh Anim=skCauldronSmallAnims
#exec Anim Digest Anim=skCauldronSmallAnims VERBOSE 

//texture import (skCauldronSmallTex0) -AdamJD 
#exec Texture Import File=Textures\skCauldronSmallTex0.png Name=skCauldronSmallTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skCauldronSmallMesh Num=0 Texture=skCauldronSmallTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skCauldronSmallMesh
}
