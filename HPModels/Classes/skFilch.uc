//================================================================================
// skFilch.
//================================================================================

class skFilch extends HPMesh
  Abstract;
  
//model import (skFilchMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skFilchMesh ModelFile=Models\skFilchMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skFilchMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skFilchAnims) -AdamJD 
#exec Anim Import Anim=skFilchAnims AnimFile=Models\skFilchAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skFilchMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skFilchMesh Anim=skFilchAnims
#exec Anim Digest Anim=skFilchAnims VERBOSE 

//texture import (skFilchTex0) -AdamJD 
#exec Texture Import File=Textures\skFilchTex0.png Name=skFilchTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFilchMesh Num=0 Texture=skFilchTex0

//texture import (skFilchTex1) -AdamJD 
#exec Texture Import File=Textures\skFilchTex1.png Name=skFilchTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFilchMesh Num=1 Texture=skFilchTex1

//texture import (skFilchTex2) -AdamJD 
#exec Texture Import File=Textures\skFilchTex2.png Name=skFilchTex2 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFilchMesh Num=2 Texture=skFilchTex2

//texture import (skFilchTex3) -AdamJD 
#exec Texture Import File=Textures\skFilchTex3.png Name=skFilchTex3 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFilchMesh Num=3 Texture=skFilchTex3

