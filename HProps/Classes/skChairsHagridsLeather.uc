//================================================================================
// skChairsHagridsLeather.
//================================================================================

class skChairsHagridsLeather extends HPMeshActor;

//model import (skChairsHagridsLeatherMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skChairsHagridsLeatherMesh ModelFile=Models\skChairsHagridsLeatherMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skChairsHagridsLeatherMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skChairsHagridsLeatherAnims) -AdamJD 
#exec Anim Import Anim=skChairsHagridsLeatherAnims AnimFile=Models\skChairsHagridsLeatherAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skChairsHagridsLeatherMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skChairsHagridsLeatherMesh Anim=skChairsHagridsLeatherAnims
#exec Anim Digest Anim=skChairsHagridsLeatherAnims VERBOSE 

//texture import (skChairsHagridsLeatherTex0) -AdamJD 
#exec Texture Import File=Textures\skChairsHagridsLeatherTex0.png Name=skChairsHagridsLeatherTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skChairsHagridsLeatherMesh Num=0 Texture=skChairsHagridsLeatherTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skChairsHagridsLeatherMesh
}
