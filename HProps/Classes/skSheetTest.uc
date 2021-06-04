//================================================================================
// skSheetTest.
//================================================================================

class skSheetTest extends HPMeshActor;

//model import (skSheetTestMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skSheetTestMesh ModelFile=Models\skSheetTestMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skSheetTestMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skSheetTestAnims) -AdamJD 
#exec Anim Import Anim=skSheetTestAnims AnimFile=Models\skSheetTestAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skSheetTestMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skSheetTestMesh Anim=skSheetTestAnims
#exec Anim Digest Anim=skSheetTestAnims VERBOSE 

//texture import (skSheetTestTex0) -AdamJD 
#exec Texture Import File=Textures\skSheetTestTex0.png Name=skSheetTestTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skSheetTestMesh Num=0 Texture=skSheetTestTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skSheetTestMesh
}
