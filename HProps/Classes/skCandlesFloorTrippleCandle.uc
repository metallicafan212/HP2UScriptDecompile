//================================================================================
// skCandlesFloorTrippleCandle.
//================================================================================

class skCandlesFloorTrippleCandle extends HPMeshActor;

//model import (skCandlesFloorTrippleCandleMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skCandlesFloorTrippleCandleMesh ModelFile=Models\skCandlesFloorTrippleCandleMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skCandlesFloorTrippleCandleMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skCandlesFloorTrippleCandleAnims) -AdamJD 
#exec Anim Import Anim=skCandlesFloorTrippleCandleAnims AnimFile=Models\skCandlesFloorTrippleCandleAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skCandlesFloorTrippleCandleMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skCandlesFloorTrippleCandleMesh Anim=skCandlesFloorTrippleCandleAnims
#exec Anim Digest Anim=skCandlesFloorTrippleCandleAnims VERBOSE 

//texture import (skCandlesFloorTrippleCandleTex0) -AdamJD 
#exec Texture Import File=Textures\skCandlesFloorTrippleCandleTex0.png Name=skCandlesFloorTrippleCandleTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skCandlesFloorTrippleCandleMesh Num=0 Texture=skCandlesFloorTrippleCandleTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skCandlesFloorTrippleCandleMesh
}
