//================================================================================
// skMapleTreeFull.
//================================================================================

class skMapleTreeFull extends HPMeshActor;

//model import (skMapleTreeFullMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skMapleTreeFullMesh ModelFile=Models\skMapleTreeFullMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skMapleTreeFullMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skMapleTreeFullAnims) -AdamJD 
#exec Anim Import Anim=skMapleTreeFullAnims AnimFile=Models\skMapleTreeFullAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skMapleTreeFullMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skMapleTreeFullMesh Anim=skMapleTreeFullAnims
#exec Anim Digest Anim=skMapleTreeFullAnims VERBOSE 

//texture import (skMapleTreeFullTex0) -AdamJD 
#exec Texture Import File=Textures\skMapleTreeFullTex0.png Name=skMapleTreeFullTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skMapleTreeFullMesh Num=0 Texture=skMapleTreeFullTex0

//texture import (skMapleTreeFullTex1) -AdamJD 
#exec Texture Import File=Textures\skMapleTreeFullTex1.png Name=skMapleTreeFullTex1 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skMapleTreeFullMesh Num=1 Texture=skMapleTreeFullTex1

//texture import (skMapleTreeFullTex2) -AdamJD 
#exec Texture Import File=Textures\skMapleTreeFullTex2.png Name=skMapleTreeFullTex2 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skMapleTreeFullMesh Num=2 Texture=skMapleTreeFullTex2

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skMapleTreeFullMesh
}
