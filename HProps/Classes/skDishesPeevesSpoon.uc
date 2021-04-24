//================================================================================
// skDishesPeevesSpoon.
//================================================================================

class skDishesPeevesSpoon extends HPMeshActor;

//model import (skDishesPeevesSpoonMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skDishesPeevesSpoonMesh ModelFile=Models\skDishesPeevesSpoonMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skDishesPeevesSpoonMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skDishesPeevesSpoonAnims) -AdamJD 
#exec Anim Import Anim=skDishesPeevesSpoonAnims AnimFile=Models\skDishesPeevesSpoonAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skDishesPeevesSpoonMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skDishesPeevesSpoonMesh Anim=skDishesPeevesSpoonAnims
#exec Anim Digest Anim=skDishesPeevesSpoonAnims VERBOSE 

//texture import (skDishesPeevesSpoonTex0) -AdamJD 
#exec Texture Import File=Textures\skDishesPeevesSpoonTex0.png Name=skDishesPeevesSpoonTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skDishesPeevesSpoonMesh Num=0 Texture=skDishesPeevesSpoonTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skDishesPeevesSpoonMesh
}
