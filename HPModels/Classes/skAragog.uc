//================================================================================
// skAragog.
//================================================================================

class skAragog extends HPMesh
  Abstract;
  
//model import (skAragogMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skAragogMesh ModelFile=Models\skAragogMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skAragogMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skAragogAnims) -AdamJD 
#exec Anim Import Anim=skAragogAnims AnimFile=Models\skAragogAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skAragogMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skAragogMesh Anim=skAragogAnims
#exec Anim Digest Anim=skAragogAnims VERBOSE 

//texture import (skAragogTex0) -AdamJD 
#exec Texture Import File=Textures\skAragogTex0.png Name=skAragogTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skAragogMesh Num=0 Texture=skAragogTex0

//texture import (skAragogTex1) -AdamJD 
#exec Texture Import File=Textures\skAragogTex1.png Name=skAragogTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skAragogMesh Num=1 Texture=skAragogTex1

//texture import (skAragogTex2) -AdamJD 
#exec Texture Import File=Textures\skAragogTex2.png Name=skAragogTex2 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skAragogMesh Num=2 Texture=skAragogTex2

