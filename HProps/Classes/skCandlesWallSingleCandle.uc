//================================================================================
// skCandlesWallSingleCandle.
//================================================================================

class skCandlesWallSingleCandle extends HPMeshActor;

//model import (skCandlesWallSingleCandleMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skCandlesWallSingleCandleMesh ModelFile=Models\skCandlesWallSingleCandleMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skCandlesWallSingleCandleMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skCandlesWallSingleCandleAnims) -AdamJD 
#exec Anim Import Anim=skCandlesWallSingleCandleAnims AnimFile=Models\skCandlesWallSingleCandleAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skCandlesWallSingleCandleMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skCandlesWallSingleCandleMesh Anim=skCandlesWallSingleCandleAnims
#exec Anim Digest Anim=skCandlesWallSingleCandleAnims VERBOSE 

//texture import (skCandlesWallSingleCandleTex0) -AdamJD 
#exec Texture Import File=Textures\skCandlesWallSingleCandleTex0.png Name=skCandlesWallSingleCandleTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skCandlesWallSingleCandleMesh Num=0 Texture=skCandlesWallSingleCandleTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skCandlesWallSingleCandleMesh
}
