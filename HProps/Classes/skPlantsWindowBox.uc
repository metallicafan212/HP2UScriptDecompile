//================================================================================
// skPlantsWindowBox.
//================================================================================

class skPlantsWindowBox extends HPMeshActor;

//model import (skPlantsWindowBoxMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skPlantsWindowBoxMesh ModelFile=Models\skPlantsWindowBoxMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skPlantsWindowBoxMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skPlantsWindowBoxAnims) -AdamJD 
#exec Anim Import Anim=skPlantsWindowBoxAnims AnimFile=Models\skPlantsWindowBoxAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skPlantsWindowBoxMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skPlantsWindowBoxMesh Anim=skPlantsWindowBoxAnims
#exec Anim Digest Anim=skPlantsWindowBoxAnims VERBOSE 

//texture import (skPlantsWindowBoxTex0) -AdamJD 
#exec Texture Import File=Textures\skPlantsWindowBoxTex0.png Name=skPlantsWindowBoxTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914 Group=Skins 
#exec MeshMap SetTexture MeshMap=skPlantsWindowBoxMesh Num=0 Texture=skPlantsWindowBoxTex0

//texture import (skPlantsWindowBoxTex1) -AdamJD 
#exec Texture Import File=Textures\skPlantsWindowBoxTex1.png Name=skPlantsWindowBoxTex1 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skPlantsWindowBoxMesh Num=1 Texture=skPlantsWindowBoxTex1

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skPlantsWindowBoxMesh
}
