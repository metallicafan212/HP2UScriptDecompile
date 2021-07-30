//================================================================================
// skYoungAragog.
//================================================================================

class skYoungAragog extends HPMesh
  Abstract;
  
//model import (skYoungAragogMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skYoungAragogMesh ModelFile=Models\skYoungAragogMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skYoungAragogMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skYoungAragogAnims) -AdamJD 
#exec Anim Import Anim=skYoungAragogAnims AnimFile=Models\skYoungAragogAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skYoungAragogMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skYoungAragogMesh Anim=skYoungAragogAnims
#exec Anim Digest Anim=skYoungAragogAnims VERBOSE 

//texture import (skYoungAragogTex0) -AdamJD 
#exec Texture Import File=Textures\skYoungAragogTex0.png Name=skYoungAragogTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skYoungAragogMesh Num=0 Texture=skYoungAragogTex0

//texture import (skYoungAragogTex1) -AdamJD 
#exec Texture Import File=Textures\skYoungAragogTex1.png Name=skYoungAragogTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skYoungAragogMesh Num=1 Texture=skYoungAragogTex1

//texture import (skYoungAragogTex2) -AdamJD 
#exec Texture Import File=Textures\skYoungAragogTex2.png Name=skYoungAragogTex2 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skYoungAragogMesh Num=2 Texture=skYoungAragogTex2

