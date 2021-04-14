//================================================================================
// skCandlesPlainCandle.
//================================================================================

class skCandlesPlainCandle extends HPMeshActor;

//model import (skCandlesPlainCandleMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skCandlesPlainCandleMesh ModelFile=Models\skCandlesPlainCandleMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skCandlesPlainCandleMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skCandlesPlainCandleAnims) -AdamJD 
#exec Anim Import Anim=skCandlesPlainCandleAnims AnimFile=Models\skCandlesPlainCandleAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skCandlesPlainCandleMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skCandlesPlainCandleMesh Anim=skCandlesPlainCandleAnims
#exec Anim Digest Anim=skCandlesPlainCandleAnims VERBOSE 

//texture import (skCandlesPlainCandleTex0) -AdamJD 
#exec Texture Import File=Textures\skCandlesPlainCandleTex0.png Name=skCandlesPlainCandleTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914 Group=Skins 
#exec MeshMap SetTexture MeshMap=skCandlesPlainCandleMesh Num=0 Texture=skCandlesPlainCandleTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skCandlesPlainCandleMesh
}
