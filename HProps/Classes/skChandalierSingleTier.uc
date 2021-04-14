//================================================================================
// skChandalierSingleTier.
//================================================================================

class skChandalierSingleTier extends HPMeshActor;

//model import (skChandalierSingleTierMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skChandalierSingleTierMesh ModelFile=Models\skChandalierSingleTierMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skChandalierSingleTierMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skChandalierSingleTierAnims) -AdamJD 
#exec Anim Import Anim=skChandalierSingleTierAnims AnimFile=Models\skChandalierSingleTierAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skChandalierSingleTierMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skChandalierSingleTierMesh Anim=skChandalierSingleTierAnims
#exec Anim Digest Anim=skChandalierSingleTierAnims VERBOSE 

//texture import (skChandalierSingleTierTex0) -AdamJD 
#exec Texture Import File=Textures\skChandalierSingleTierTex0.png Name=skChandalierSingleTierTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skChandalierSingleTierMesh Num=0 Texture=skChandalierSingleTierTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skChandalierSingleTierMesh
}
