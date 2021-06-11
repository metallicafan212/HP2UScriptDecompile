//================================================================================
// skTitleTest.
//================================================================================

class skTitleTest extends HPMeshActor;

//model import (skTitleTestMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skTitleTestMesh ModelFile=Models\skTitleTestMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skTitleTestMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skTitleTestAnims) -AdamJD 
#exec Anim Import Anim=skTitleTestAnims AnimFile=Models\skTitleTestAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skTitleTestMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skTitleTestMesh Anim=skTitleTestAnims
#exec Anim Digest Anim=skTitleTestAnims VERBOSE 

//texture import (skTitleTestTex0) -AdamJD 
#exec Texture Import File=Textures\skTitleTestTex0.png Name=skTitleTestTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skTitleTestMesh Num=0 Texture=skTitleTestTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skTitleTestMesh
}
