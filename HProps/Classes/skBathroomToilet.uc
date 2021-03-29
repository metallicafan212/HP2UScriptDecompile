//================================================================================
// skBathroomToilet.
//================================================================================

class skBathroomToilet extends HPMeshActor;

//model import (skBathroomToiletMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBathroomToiletMesh ModelFile=Models\skBathroomToiletMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBathroomToiletMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBathroomToiletAnims) -AdamJD 
#exec Anim Import Anim=skBathroomToiletAnims AnimFile=Models\skBathroomToiletAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBathroomToiletMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBathroomToiletMesh Anim=skBathroomToiletAnims
#exec Anim Digest Anim=skBathroomToiletAnims VERBOSE 

//texture import (skBathroomToiletTex0) -AdamJD 
#exec Texture Import File=Textures\skBathroomToiletTex0.png Name=skBathroomToiletTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBathroomToiletMesh Num=0 Texture=skBathroomToiletTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBathroomToiletMesh
}
