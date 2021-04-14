//================================================================================
// skCandlesTableSingleCandle.
//================================================================================

class skCandlesTableSingleCandle extends HPMeshActor;

//model import (skCandlesTableSingleCandleMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skCandlesTableSingleCandleMesh ModelFile=Models\skCandlesTableSingleCandleMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skCandlesTableSingleCandleMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skCandlesTableSingleCandleAnims) -AdamJD 
#exec Anim Import Anim=skCandlesTableSingleCandleAnims AnimFile=Models\skCandlesTableSingleCandleAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skCandlesTableSingleCandleMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skCandlesTableSingleCandleMesh Anim=skCandlesTableSingleCandleAnims
#exec Anim Digest Anim=skCandlesTableSingleCandleAnims VERBOSE 

//texture import (skCandlesTableSingleCandleTex0) -AdamJD 
#exec Texture Import File=Textures\skCandlesTableSingleCandleTex0.png Name=skCandlesTableSingleCandleTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skCandlesTableSingleCandleMesh Num=0 Texture=skCandlesTableSingleCandleTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skCandlesTableSingleCandleMesh
}
