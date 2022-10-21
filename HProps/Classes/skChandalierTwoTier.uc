//================================================================================
// skChandalierTwoTier.
//================================================================================

class skChandalierTwoTier extends HPMeshActor;

//model import (skChandalierTwoTierMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skChandalierTwoTierMesh ModelFile=Models\skChandalierTwoTierMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skChandalierTwoTierMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skChandalierTwoTierAnims) -AdamJD 
#exec Anim Import Anim=skChandalierTwoTierAnims AnimFile=Models\skChandalierTwoTierAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skChandalierTwoTierMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skChandalierTwoTierMesh Anim=skChandalierTwoTierAnims
#exec Anim Digest Anim=skChandalierTwoTierAnims VERBOSE 

//texture import (skChandalierTwoTierTex0) -AdamJD 
#exec Texture Import File=Textures\skChandalierTwoTierTex0.png Name=skChandalierTwoTierTex0 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skChandalierTwoTierMesh Num=0 Texture=skChandalierTwoTierTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skChandalierTwoTierMesh
}
