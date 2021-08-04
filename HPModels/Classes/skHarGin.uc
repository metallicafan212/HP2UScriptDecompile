//================================================================================
// skHarGin.
//================================================================================

class skHarGin extends HPMesh
  Abstract;
  
//model import (skHarGinMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skHarGinMesh ModelFile=Models\skHarGinMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skHarGinMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skHarGinAnims) -AdamJD 
#exec Anim Import Anim=skHarGinAnims AnimFile=Models\skHarGinAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skHarGinMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skHarGinMesh Anim=skHarGinAnims
#exec Anim Digest Anim=skHarGinAnims VERBOSE 

//texture import (skHarGinTex0) -AdamJD 
#exec Texture Import File=Textures\skHarGinTex0.png Name=skHarGinTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHarGinMesh Num=0 Texture=skHarGinTex0

//texture import (skHarGinTex1) -AdamJD 
#exec Texture Import File=Textures\skHarGinTex1.png Name=skHarGinTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHarGinMesh Num=1 Texture=skHarGinTex1

//texture import (skHarGinTex2) -AdamJD 
#exec Texture Import File=Textures\skHarGinTex2.png Name=skHarGinTex2 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHarGinMesh Num=2 Texture=skHarGinTex2

//texture import (skHarGinTex3) -AdamJD 
#exec Texture Import File=Textures\skHarGinTex3.png Name=skHarGinTex3 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHarGinMesh Num=3 Texture=skHarGinTex3

//texture import (skHarGinTex4) -AdamJD 
#exec Texture Import File=Textures\skHarGinTex4.png Name=skHarGinTex4 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHarGinMesh Num=4 Texture=skHarGinTex4

//texture import (skHarGinTex5) -AdamJD 
#exec Texture Import File=Textures\skHarGinTex5.png Name=skHarGinTex5 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHarGinMesh Num=5 Texture=skHarGinTex5

