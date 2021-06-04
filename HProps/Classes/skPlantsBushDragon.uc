//================================================================================
// skPlantsBushDragon.
//================================================================================

class skPlantsBushDragon extends HPMeshActor;

//model import (skPlantsBushDragonMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skPlantsBushDragonMesh ModelFile=Models\skPlantsBushDragonMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skPlantsBushDragonMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skPlantsBushDragonAnims) -AdamJD 
#exec Anim Import Anim=skPlantsBushDragonAnims AnimFile=Models\skPlantsBushDragonAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skPlantsBushDragonMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skPlantsBushDragonMesh Anim=skPlantsBushDragonAnims
#exec Anim Digest Anim=skPlantsBushDragonAnims VERBOSE 

//texture import (skPlantsBushDragonTex0) -AdamJD 
#exec Texture Import File=Textures\skPlantsBushDragonTex0.png Name=skPlantsBushDragonTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914 Group=Skins 
#exec MeshMap SetTexture MeshMap=skPlantsBushDragonMesh Num=0 Texture=skPlantsBushDragonTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skPlantsBushDragonMesh
}
