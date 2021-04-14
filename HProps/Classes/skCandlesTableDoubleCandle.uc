//================================================================================
// skCandlesTableDoubleCandle.
//================================================================================

class skCandlesTableDoubleCandle extends HPMeshActor;

//model import (skCandlesTableDoubleCandleMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skCandlesTableDoubleCandleMesh ModelFile=Models\skCandlesTableDoubleCandleMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skCandlesTableDoubleCandleMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0

//anim import (skCandlesTableDoubleCandleAnims) -AdamJD 
#exec Anim Import Anim=skCandlesTableDoubleCandleAnims AnimFile=Models\skCandlesTableDoubleCandleAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skCandlesTableDoubleCandleMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skCandlesTableDoubleCandleMesh Anim=skCandlesTableDoubleCandleAnims
#exec Anim Digest Anim=skCandlesTableDoubleCandleAnims VERBOSE 

//texture import (skCandlesTableDoubleCandleTex0) -AdamJD 
#exec Texture Import File=Textures\skCandlesTableDoubleCandleTex0.png Name=skCandlesTableDoubleCandleTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skCandlesTableDoubleCandleMesh Num=0 Texture=skCandlesTableDoubleCandleTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skCandlesTableDoubleCandleMesh
}
