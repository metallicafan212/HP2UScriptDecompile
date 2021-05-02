//================================================================================
// skharrybed.
//================================================================================

class skharrybed extends HPMeshActor;

//model import (skharrybedMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skharrybedMesh ModelFile=Models\skharrybedMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skharrybedMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skharrybedAnims) -AdamJD 
#exec Anim Import Anim=skharrybedAnims AnimFile=Models\skharrybedAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skharrybedMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skharrybedMesh Anim=skharrybedAnims
#exec Anim Digest Anim=skharrybedAnims VERBOSE 

//texture import (skharrybedTex0) -AdamJD 
#exec Texture Import File=Textures\skharrybedTex0.png Name=skharrybedTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skharrybedMesh Num=0 Texture=skharrybedTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skharrybedMesh
}
