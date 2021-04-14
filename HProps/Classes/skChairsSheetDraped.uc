//================================================================================
// skChairsSheetDraped.
//================================================================================

class skChairsSheetDraped extends HPMeshActor;

//model import (skChairsSheetDrapedMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skChairsSheetDrapedMesh ModelFile=Models\skChairsSheetDrapedMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skChairsSheetDrapedMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skChairsSheetDrapedAnims) -AdamJD 
#exec Anim Import Anim=skChairsSheetDrapedAnims AnimFile=Models\skChairsSheetDrapedAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skChairsSheetDrapedMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skChairsSheetDrapedMesh Anim=skChairsSheetDrapedAnims
#exec Anim Digest Anim=skChairsSheetDrapedAnims VERBOSE 

//texture import (skChairsSheetDrapedTex0) -AdamJD 
#exec Texture Import File=Textures\skChairsSheetDrapedTex0.png Name=skChairsSheetDrapedTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skChairsSheetDrapedMesh Num=0 Texture=skChairsSheetDrapedTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skChairsSheetDrapedMesh
}
