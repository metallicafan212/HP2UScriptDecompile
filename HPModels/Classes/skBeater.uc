//================================================================================
// skBeater.
//================================================================================

class skBeater extends HPMesh
  Abstract;
  
//model import (skBeaterMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBeaterMesh ModelFile=Models\skBeaterMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBeaterMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBeaterAnims) -AdamJD 
#exec Anim Import Anim=skBeaterAnims AnimFile=Models\skBeaterAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBeaterMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBeaterMesh Anim=skBeaterAnims
#exec Anim Digest Anim=skBeaterAnims VERBOSE 

//texture import (skBeater_HTex0) -AdamJD 
#exec Texture Import File=Textures\skBeater_HTex0.png Name=skBeater_HTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 

//texture import (skBeater_RTex0) -AdamJD 
#exec Texture Import File=Textures\skBeater_RTex0.png Name=skBeater_RTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 

//texture import (skBeater_STex0) -AdamJD 
#exec Texture Import File=Textures\skBeater_STex0.png Name=skBeater_STex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 

//texture import (skBeater_GTex0) -AdamJD 
#exec Texture Import File=Textures\skBeater_GTex0.png Name=skBeater_GTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBeaterMesh Num=0 Texture=skBeater_GTex0

//texture import (skBeater_Tex1) -AdamJD 
#exec Texture Import File=Textures\skBeater_Tex1.png Name=skBeater_Tex1 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBeaterMesh Num=1 Texture=skBeater_Tex1

//texture import (skBeater_Tex2) -AdamJD 
#exec Texture Import File=Textures\skBeater_Tex2.png Name=skBeater_Tex2 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBeaterMesh Num=2 Texture=skBeater_Tex2

