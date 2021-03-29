//================================================================================
// skBathroomToiletTank.
//================================================================================

class skBathroomToiletTank extends HPMeshActor;

//model import (skBathroomToiletTankMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBathroomToiletTankMesh ModelFile=Models\skBathroomToiletTankMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBathroomToiletTankMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBathroomToiletTankAnims) -AdamJD 
#exec Anim Import Anim=skBathroomToiletTankAnims AnimFile=Models\skBathroomToiletTankAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBathroomToiletTankMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBathroomToiletTankMesh Anim=skBathroomToiletTankAnims
#exec Anim Digest Anim=skBathroomToiletTankAnims VERBOSE 

//texture import (skBathroomToiletTankTex0) -AdamJD 
#exec Texture Import File=Textures\skBathroomToiletTankTex0.png Name=skBathroomToiletTankTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBathroomToiletTankMesh Num=0 Texture=skBathroomToiletTankTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBathroomToiletTankMesh
}
