//================================================================================
// skBugCave.
//================================================================================

class skBugCave extends HPMeshActor;

//model import (skBugCaveMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBugCaveMesh ModelFile=Models\skBugCaveMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBugCaveMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBugCaveAnims) -AdamJD 
#exec Anim Import Anim=skBugCaveAnims AnimFile=Models\skBugCaveAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBugCaveMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBugCaveMesh Anim=skBugCaveAnims
#exec Anim Digest Anim=skBugCaveAnims VERBOSE 

//texture import (skBugCaveTex0) -AdamJD 
#exec Texture Import File=Textures\skBugCaveTex0.png Name=skBugCaveTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBugCaveMesh Num=0 Texture=skBugCaveTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBugCaveMesh
}
