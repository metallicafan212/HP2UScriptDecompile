//================================================================================
// skCandlesFloorSingleCandle.
//================================================================================

class skCandlesFloorSingleCandle extends HPMeshActor;

//model import (skCandlesFloorSingleCandleMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skCandlesFloorSingleCandleMesh ModelFile=Models\skCandlesFloorSingleCandleMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skCandlesFloorSingleCandleMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skCandlesFloorSingleCandleAnims) -AdamJD 
#exec Anim Import Anim=skCandlesFloorSingleCandleAnims AnimFile=Models\skCandlesFloorSingleCandleAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skCandlesFloorSingleCandleMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skCandlesFloorSingleCandleMesh Anim=skCandlesFloorSingleCandleAnims
#exec Anim Digest Anim=skCandlesFloorSingleCandleAnims VERBOSE 

//texture import (skCandlesFloorSingleCandleTex0) -AdamJD 
#exec Texture Import File=Textures\skCandlesFloorSingleCandleTex0.png Name=skCandlesFloorSingleCandleTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skCandlesFloorSingleCandleMesh Num=0 Texture=skCandlesFloorSingleCandleTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skCandlesFloorSingleCandleMesh
}
