//================================================================================
// skPlantsHangingPlant1.
//================================================================================

class skPlantsHangingPlant1 extends HPMeshActor;

//model import (skPlantsHangingPlant1Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skPlantsHangingPlant1Mesh ModelFile=Models\skPlantsHangingPlant1Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skPlantsHangingPlant1Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skPlantsHangingPlant1Anims) -AdamJD 
#exec Anim Import Anim=skPlantsHangingPlant1Anims AnimFile=Models\skPlantsHangingPlant1Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skPlantsHangingPlant1Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skPlantsHangingPlant1Mesh Anim=skPlantsHangingPlant1Anims
#exec Anim Digest Anim=skPlantsHangingPlant1Anims VERBOSE 

//texture import (skPlantsHangingPlant1Tex0) -AdamJD 
#exec Texture Import File=Textures\skPlantsHangingPlant1Tex0.png Name=skPlantsHangingPlant1Tex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skPlantsHangingPlant1Mesh Num=0 Texture=skPlantsHangingPlant1Tex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skPlantsHangingPlant1Mesh
}
