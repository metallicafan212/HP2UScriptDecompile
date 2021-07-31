//================================================================================
// skChairsHagridsWood.
//================================================================================

class skChairsHagridsWood extends HPMeshActor;

//model import (skChairsHagridsWoodMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skChairsHagridsWoodMesh ModelFile=Models\skChairsHagridsWoodMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skChairsHagridsWoodMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skChairsHagridsWoodAnims) -AdamJD 
#exec Anim Import Anim=skChairsHagridsWoodAnims AnimFile=Models\skChairsHagridsWoodAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skChairsHagridsWoodMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skChairsHagridsWoodMesh Anim=skChairsHagridsWoodAnims
#exec Anim Digest Anim=skChairsHagridsWoodAnims VERBOSE 

//texture import (skChairsHagridsWoodTex0) -AdamJD 
#exec Texture Import File=Textures\skChairsHagridsWoodTex0.png Name=skChairsHagridsWoodTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skChairsHagridsWoodMesh Num=0 Texture=skChairsHagridsWoodTex0

//texture import (skChairsHagridsWoodTex1) -AdamJD 
#exec Texture Import File=Textures\skChairsHagridsWoodTex1.png Name=skChairsHagridsWoodTex1 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skChairsHagridsWoodMesh Num=1 Texture=skChairsHagridsWoodTex1

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skChairsHagridsWoodMesh
}
