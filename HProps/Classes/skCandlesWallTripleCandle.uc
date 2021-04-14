//================================================================================
// skCandlesWallTripleCandle.
//================================================================================

class skCandlesWallTripleCandle extends HPMeshActor;

//model import (skCandlesWallTripleCandleMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skCandlesWallTripleCandleMesh ModelFile=Models\skCandlesWallTripleCandleMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skCandlesWallTripleCandleMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skCandlesWallTripleCandleAnims) -AdamJD 
#exec Anim Import Anim=skCandlesWallTripleCandleAnims AnimFile=Models\skCandlesWallTripleCandleAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skCandlesWallTripleCandleMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skCandlesWallTripleCandleMesh Anim=skCandlesWallTripleCandleAnims
#exec Anim Digest Anim=skCandlesWallTripleCandleAnims VERBOSE 

//texture import (skCandlesWallTripleCandleTex0) -AdamJD 
#exec Texture Import File=Textures\skCandlesWallTripleCandleTex0.png Name=skCandlesWallTripleCandleTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914 Group=Skins 
#exec MeshMap SetTexture MeshMap=skCandlesWallTripleCandleMesh Num=0 Texture=skCandlesWallTripleCandleTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skCandlesWallTripleCandleMesh
}
