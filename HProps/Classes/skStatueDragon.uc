//================================================================================
// skStatueDragon.
//================================================================================

class skStatueDragon extends HPMeshActor;

//model import (skStatueDragonMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skStatueDragonMesh ModelFile=Models\skStatueDragonMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skStatueDragonMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skStatueDragonAnims) -AdamJD 
#exec Anim Import Anim=skStatueDragonAnims AnimFile=Models\skStatueDragonAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skStatueDragonMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skStatueDragonMesh Anim=skStatueDragonAnims
#exec Anim Digest Anim=skStatueDragonAnims VERBOSE

//texture import (skStatueDragonTex0) -AdamJD 
#exec Texture Import File=Textures\skStatueDragonTex0.png Name=skStatueDragonTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skStatueDragonMesh Num=0 Texture=skStatueDragonTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skStatueDragonMesh
}
