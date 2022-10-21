//================================================================================
// skChandalierThreeTier.
//================================================================================

class skChandalierThreeTier extends HPMeshActor;

//model import (skChandalierThreeTierMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skChandalierThreeTierMesh ModelFile=Models\skChandalierThreeTierMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skChandalierThreeTierMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skChandalierThreeTierAnims) -AdamJD 
#exec Anim Import Anim=skChandalierThreeTierAnims AnimFile=Models\skChandalierThreeTierAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skChandalierThreeTierMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skChandalierThreeTierMesh Anim=skChandalierThreeTierAnims
#exec Anim Digest Anim=skChandalierThreeTierAnims VERBOSE 

//texture import (skChandalierThreeTierTex0) -AdamJD 
#exec Texture Import File=Textures\skChandalierThreeTierTex0.png Name=skChandalierThreeTierTex0 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skChandalierThreeTierMesh Num=0 Texture=skChandalierThreeTierTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skChandalierThreeTierMesh
}
