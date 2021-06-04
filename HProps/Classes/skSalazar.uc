//================================================================================
// skSalazar.
//================================================================================

class skSalazar extends HPMeshActor;

//model import (skSalazarMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skSalazarMesh ModelFile=Models\skSalazarMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skSalazarMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skSalazarAnims) -AdamJD 
#exec Anim Import Anim=skSalazarAnims AnimFile=Models\skSalazarAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skSalazarMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skSalazarMesh Anim=skSalazarAnims
#exec Anim Digest Anim=skSalazarAnims VERBOSE 

//texture import (skSalazarTex0) -AdamJD 
#exec Texture Import File=Textures\skSalazarTex0.png Name=skSalazarTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skSalazarMesh Num=0 Texture=skSalazarTex0

//texture import (skSalazarTex1) -AdamJD 
#exec Texture Import File=Textures\skSalazarTex1.png Name=skSalazarTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skSalazarMesh Num=1 Texture=skSalazarTex1

//texture import (skSalazarTex2) -AdamJD 
#exec Texture Import File=Textures\skSalazarTex2.png Name=skSalazarTex2 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skSalazarMesh Num=2 Texture=skSalazarTex2

//texture import (skSalazarTex3) -AdamJD 
#exec Texture Import File=Textures\skSalazarTex3.png Name=skSalazarTex3 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skSalazarMesh Num=3 Texture=skSalazarTex3

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skSalazarMesh
}
