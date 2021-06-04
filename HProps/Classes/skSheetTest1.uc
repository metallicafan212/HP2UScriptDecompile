//================================================================================
// skSheetTest1.
//================================================================================

class skSheetTest1 extends HPMeshActor;

//model import (skSheetTest1Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skSheetTest1Mesh ModelFile=Models\skSheetTest1Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skSheetTest1Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0
//this is meant to be invisible -AdamJD

//anim import (skSheetTest1Anims) -AdamJD 
#exec Anim Import Anim=skSheetTest1Anims AnimFile=Models\skSheetTest1Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skSheetTest1Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skSheetTest1Mesh Anim=skSheetTest1Anims
#exec Anim Digest Anim=skSheetTest1Anims VERBOSE

//texture import (skSheetTest1Tex0) -AdamJD 
#exec Texture Import File=Textures\skSheetTest1Tex0.png Name=skSheetTest1Tex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skSheetTest1Mesh Num=0 Texture=skSheetTest1Tex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skSheetTest1Mesh
}
