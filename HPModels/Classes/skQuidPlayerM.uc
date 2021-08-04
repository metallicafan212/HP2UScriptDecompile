//================================================================================
// skQuidPlayerM.
//================================================================================

class skQuidPlayerM extends HPMesh
  Abstract;
  
//model import (skQuidPlayerMMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skQuidPlayerMMesh ModelFile=Models\skQuidPlayerMMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skQuidPlayerMMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//shared anim import (skHarryQuidAnims) -AdamJD 
#exec MeshMap Scale MeshMap=skQuidPlayerMMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skQuidPlayerMMesh Anim=skHarryQuidAnims

//texture import (skQuidPlayerM_HTex0) -AdamJD 
#exec Texture Import File=Textures\skQuidPlayerM_HTex0.png Name=skQuidPlayerM_HTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 

//texture import (skQuidPlayerM_RTex0) -AdamJD 
#exec Texture Import File=Textures\skQuidPlayerM_RTex0.png Name=skQuidPlayerM_RTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 

//texture import (skQuidPlayerM_STex0) -AdamJD 
#exec Texture Import File=Textures\skQuidPlayerM_STex0.png Name=skQuidPlayerM_STex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins

//texture import (skQuidPlayerM_GTex0) -AdamJD 
#exec Texture Import File=Textures\skQuidPlayerM_GTex0.png Name=skQuidPlayerM_GTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skQuidPlayerMMesh Num=0 Texture=skQuidPlayerM_GTex0 

//texture import (skQuidPlayerM_Tex1) -AdamJD 
#exec Texture Import File=Textures\skQuidPlayerM_Tex1.png Name=skQuidPlayerM_Tex1 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skQuidPlayerMMesh Num=1 Texture=skQuidPlayerM_Tex1

