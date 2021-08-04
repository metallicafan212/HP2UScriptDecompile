//================================================================================
// skQuidPlayerF.
//================================================================================

class skQuidPlayerF extends HPMesh
  Abstract;
  
//model import (skQuidPlayerFMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skQuidPlayerFMesh ModelFile=Models\skQuidPlayerFMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skQuidPlayerFMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//shared anim import (skHarryQuidAnims) -AdamJD 
#exec MeshMap Scale MeshMap=skQuidPlayerFMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skQuidPlayerFMesh Anim=skHarryQuidAnims

//texture import (skQuidPlayerF_HTex0) -AdamJD 
#exec Texture Import File=Textures\skQuidPlayerF_HTex0.png Name=skQuidPlayerF_HTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 

//texture import (skQuidPlayerF_RTex0) -AdamJD 
#exec Texture Import File=Textures\skQuidPlayerF_RTex0.png Name=skQuidPlayerF_RTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 

//texture import (skQuidPlayerF_STex0) -AdamJD 
#exec Texture Import File=Textures\skQuidPlayerF_STex0.png Name=skQuidPlayerF_STex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins

//texture import (skQuidPlayerF_GTex0) -AdamJD 
#exec Texture Import File=Textures\skQuidPlayerF_GTex0.png Name=skQuidPlayerF_GTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skQuidPlayerFMesh Num=0 Texture=skQuidPlayerF_GTex0 

//texture import (skQuidPlayerF_Tex1) -AdamJD 
#exec Texture Import File=Textures\skQuidPlayerF_Tex1.png Name=skQuidPlayerF_Tex1 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skQuidPlayerFMesh Num=1 Texture=skQuidPlayerF_Tex1

