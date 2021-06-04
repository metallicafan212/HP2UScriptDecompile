//================================================================================
// skStatueOwl.
//================================================================================

class skStatueOwl extends HPMeshActor;

//model import (skStatueOwlMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skStatueOwlMesh ModelFile=Models\skStatueOwlMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skStatueOwlMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skStatueOwlAnims) -AdamJD 
#exec Anim Import Anim=skStatueOwlAnims AnimFile=Models\skStatueOwlAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skStatueOwlMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skStatueOwlMesh Anim=skStatueOwlAnims
#exec Anim Digest Anim=skStatueOwlAnims VERBOSE 

//texture import (skStatueOwlTex0) -AdamJD 
#exec Texture Import File=Textures\skStatueOwlTex0.png Name=skStatueOwlTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skStatueOwlMesh Num=0 Texture=skStatueOwlTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skStatueOwlMesh
}
