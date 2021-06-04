//================================================================================
// skPlantsEmptyPot.
//================================================================================

class skPlantsEmptyPot extends HPMeshActor;

//model import (skPlantsEmptyPotMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skPlantsEmptyPotMesh ModelFile=Models\skPlantsEmptyPotMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skPlantsEmptyPotMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skPlantsEmptyPotAnims) -AdamJD 
#exec Anim Import Anim=skPlantsEmptyPotAnims AnimFile=Models\skPlantsEmptyPotAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skPlantsEmptyPotMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skPlantsEmptyPotMesh Anim=skPlantsEmptyPotAnims
#exec Anim Digest Anim=skPlantsEmptyPotAnims VERBOSE 

//texture import (skPlantsEmptyPotTex0) -AdamJD 
#exec Texture Import File=Textures\skPlantsEmptyPotTex0.png Name=skPlantsEmptyPotTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skPlantsEmptyPotMesh Num=0 Texture=skPlantsEmptyPotTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skPlantsEmptyPotMesh
}
