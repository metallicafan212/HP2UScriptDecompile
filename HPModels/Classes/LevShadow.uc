//================================================================================
// LevShadow.
//================================================================================

class LevShadow extends Actor;

//model import (LevShadowMesh) -AdamJD 
#exec Mesh ModelImport Mesh=LevShadowMesh ModelFile=Models\LevShadowMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=LevShadowMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0
//this is meant to be invisible -AdamJD 

//anim import (LevShadowAnims) -AdamJD 
#exec Anim Import Anim=LevShadowAnims AnimFile=Models\LevShadowAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=LevShadowMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=LevShadowMesh Anim=LevShadowAnims
#exec Anim Digest Anim=LevShadowAnims VERBOSE 

//texture import (LevShadowTex0) -AdamJD 
#exec Texture Import File=Textures\LevShadowTex0.png Name=LevShadowTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=LevShadowMesh Num=0 Texture=LevShadowTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=LevShadowMesh
}
