//================================================================================
// skCandlesFloorTrippleCandleSepia.
//================================================================================

class skCandlesFloorTrippleCandleSepia extends HPMeshActor;

//model import (skCandlesFloorTrippleCandleSepiaMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skCandlesFloorTrippleCandleSepiaMesh ModelFile=Models\skCandlesFloorTrippleCandleSepiaMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skCandlesFloorTrippleCandleSepiaMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skCandlesFloorTrippleCandleSepiaAnims) -AdamJD 
#exec Anim Import Anim=skCandlesFloorTrippleCandleSepiaAnims AnimFile=Models\skCandlesFloorTrippleCandleSepiaAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skCandlesFloorTrippleCandleSepiaMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skCandlesFloorTrippleCandleSepiaMesh Anim=skCandlesFloorTrippleCandleSepiaAnims
#exec Anim Digest Anim=skCandlesFloorTrippleCandleSepiaAnims VERBOSE 

//texture import (skCandlesFloorTrippleCandleSepiaTex0) -AdamJD 
#exec Texture Import File=Textures\skCandlesFloorTrippleCandleSepiaTex0.png Name=skCandlesFloorTrippleCandleSepiaTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skCandlesFloorTrippleCandleSepiaMesh Num=0 Texture=skCandlesFloorTrippleCandleSepiaTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skCandlesFloorTrippleCandleSepiaMesh
}
