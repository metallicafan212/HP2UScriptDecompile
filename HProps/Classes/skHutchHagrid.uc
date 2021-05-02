//================================================================================
// skHutchHagrid.
//================================================================================

class skHutchHagrid extends HPMeshActor;

//model import (skHutchHagridMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skHutchHagridMesh ModelFile=Models\skHutchHagridMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skHutchHagridMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skHutchHagridAnims) -AdamJD 
#exec Anim Import Anim=skHutchHagridAnims AnimFile=Models\skHutchHagridAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skHutchHagridMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skHutchHagridMesh Anim=skHutchHagridAnims
#exec Anim Digest Anim=skHutchHagridAnims VERBOSE 

//texture import (skHutchHagridTex0) -AdamJD 
#exec Texture Import File=Textures\skHutchHagridTex0.png Name=skHutchHagridTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHutchHagridMesh Num=0 Texture=skHutchHagridTex0

//texture import (skHutchHagridTex1) -AdamJD 
#exec Texture Import File=Textures\skHutchHagridTex1.png Name=skHutchHagridTex1 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHutchHagridMesh Num=1 Texture=skHutchHagridTex1

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skHutchHagridMesh
}
