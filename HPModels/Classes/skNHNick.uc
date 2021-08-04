//================================================================================
// skNHNick.
//================================================================================

class skNHNick extends HPMesh
  Abstract;
  
//model import (skNHNickMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skNHNickMesh ModelFile=Models\skNHNickMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skNHNickMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skNHNickAnims) -AdamJD 
#exec Anim Import Anim=skNHNickAnims AnimFile=Models\skNHNickAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skNHNickMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skNHNickMesh Anim=skNHNickAnims
#exec Anim Digest Anim=skNHNickAnims VERBOSE 

//texture import (skNHNickTex0) -AdamJD 
#exec Texture Import File=Textures\skNHNickTex0.png Name=skNHNickTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skNHNickMesh Num=0 Texture=skNHNickTex0

//texture import (skNHNickTex1) -AdamJD 
#exec Texture Import File=Textures\skNHNickTex1.png Name=skNHNickTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skNHNickMesh Num=1 Texture=skNHNickTex1

//texture import (skNHNickTex2) -AdamJD 
#exec Texture Import File=Textures\skNHNickTex2.png Name=skNHNickTex2 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skNHNickMesh Num=2 Texture=skNHNickTex2

