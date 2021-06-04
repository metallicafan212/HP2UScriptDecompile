//================================================================================
// skPlantsFlowerRed.
//================================================================================

class skPlantsFlowerRed extends HPMeshActor;

//model import (skPlantsFlowerRedMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skPlantsFlowerRedMesh ModelFile=Models\skPlantsFlowerRedMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skPlantsFlowerRedMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skPlantsFlowerRedAnims) -AdamJD 
#exec Anim Import Anim=skPlantsFlowerRedAnims AnimFile=Models\skPlantsFlowerRedAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skPlantsFlowerRedMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skPlantsFlowerRedMesh Anim=skPlantsFlowerRedAnims
#exec Anim Digest Anim=skPlantsFlowerRedAnims VERBOSE 

//texture import (skPlantsFlowerRedTex0) -AdamJD 
#exec Texture Import File=Textures\skPlantsFlowerRedTex0.png Name=skPlantsFlowerRedTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914 Group=Skins 
#exec MeshMap SetTexture MeshMap=skPlantsFlowerRedMesh Num=0 Texture=skPlantsFlowerRedTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skPlantsFlowerRedMesh
}
