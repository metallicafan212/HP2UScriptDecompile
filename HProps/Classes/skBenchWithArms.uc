//================================================================================
// skBenchWithArms.
//================================================================================

class skBenchWithArms extends HPMeshActor;

//model import (skBenchWithArmsMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBenchWithArmsMesh ModelFile=Models\skBenchWithArmsMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBenchWithArmsMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0

//anim import (skBenchWithArmsAnims) -AdamJD 
#exec Anim Import Anim=skBenchWithArmsAnims AnimFile=Models\skBenchWithArmsAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBenchWithArmsMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBenchWithArmsMesh Anim=skBenchWithArmsAnims
#exec Anim Digest Anim=skBenchWithArmsAnims VERBOSE 

//texture import (skBenchWithArmsTex0) -AdamJD 
#exec Texture Import File=Textures\skBenchWithArmsTex0.png Name=skBenchWithArmsTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBenchWithArmsMesh Num=0 Texture=skBenchWithArmsTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBenchWithArmsMesh
}
