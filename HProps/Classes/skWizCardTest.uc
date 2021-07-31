//================================================================================
// skWizCardTest.
//================================================================================

class skWizCardTest extends HPMeshActor;

//model import (skWizCardTestMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skWizCardTestMesh ModelFile=Models\skWizCardTestMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skWizCardTestMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skWizCardTestAnims) -AdamJD 
#exec Anim Import Anim=skWizCardTestAnims AnimFile=Models\skWizCardTestAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skWizCardTestMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skWizCardTestMesh Anim=skWizCardTestAnims
#exec Anim Digest Anim=skWizCardTestAnims VERBOSE 

//texture import (skWizCardTestTex0) -AdamJD 
#exec Texture Import File=Textures\skWizCardTestTex0.png Name=skWizCardTestTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skWizCardTestMesh Num=0 Texture=skWizCardTestTex0

//texture import (skWizCardTestTex1) -AdamJD 
#exec Texture Import File=Textures\skWizCardTestTex1.png Name=skWizCardTestTex1 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skWizCardTestMesh Num=1 Texture=skWizCardTestTex1

//texture import (skWizCardTestTex2) -AdamJD 
#exec Texture Import File=Textures\skWizCardTestTex2.png Name=skWizCardTestTex2 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skWizCardTestMesh Num=2 Texture=skWizCardTestTex2

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skWizCardTestMesh
}
