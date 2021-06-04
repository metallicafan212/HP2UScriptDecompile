//================================================================================
// skPlantsFlowerYellow.
//================================================================================

class skPlantsFlowerYellow extends HPMeshActor;

//model import (skPlantsFlowerYellowMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skPlantsFlowerYellowMesh ModelFile=Models\skPlantsFlowerYellowMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skPlantsFlowerYellowMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skPlantsFlowerYellowAnims) -AdamJD 
#exec Anim Import Anim=skPlantsFlowerYellowAnims AnimFile=Models\skPlantsFlowerYellowAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skPlantsFlowerYellowMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skPlantsFlowerYellowMesh Anim=skPlantsFlowerYellowAnims
#exec Anim Digest Anim=skPlantsFlowerYellowAnims VERBOSE 

//texture import (skPlantsFlowerYellowTex0) -AdamJD 
#exec Texture Import File=Textures\skPlantsFlowerYellowTex0.png Name=skPlantsFlowerYellowTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914 Group=Skins 
#exec MeshMap SetTexture MeshMap=skPlantsFlowerYellowMesh Num=0 Texture=skPlantsFlowerYellowTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skPlantsFlowerYellowMesh
}
