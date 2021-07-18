//================================================================================
// skNHNickPetrified.
//================================================================================

class skNHNickPetrified extends HPMesh
  Abstract;
  
//model import (skNHNickPetrifiedMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skNHNickPetrifiedMesh ModelFile=Models\skNHNickPetrifiedMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skNHNickPetrifiedMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skNHNickPetrifiedAnims) -AdamJD 
#exec Anim Import Anim=skNHNickPetrifiedAnims AnimFile=Models\skNHNickPetrifiedAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skNHNickPetrifiedMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skNHNickPetrifiedMesh Anim=skNHNickPetrifiedAnims
#exec Anim Digest Anim=skNHNickPetrifiedAnims VERBOSE 

//texture import (skNHNickPetrifiedTex0) -AdamJD 
#exec Texture Import File=Textures\skNHNickPetrifiedTex0.png Name=skNHNickPetrifiedTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skNHNickPetrifiedMesh Num=0 Texture=skNHNickPetrifiedTex0

//texture import (skNHNickPetrifiedTex1) -AdamJD 
#exec Texture Import File=Textures\skNHNickPetrifiedTex1.png Name=skNHNickPetrifiedTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skNHNickPetrifiedMesh Num=1 Texture=skNHNickPetrifiedTex1

//texture import (skNHNickPetrifiedTex2) -AdamJD 
#exec Texture Import File=Textures\skNHNickPetrifiedTex2.png Name=skNHNickPetrifiedTex2 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skNHNickPetrifiedMesh Num=2 Texture=skNHNickPetrifiedTex2

