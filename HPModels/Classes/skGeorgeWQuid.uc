//================================================================================
// skGeorgeWQuid.
//================================================================================

class skGeorgeWQuid extends HPMesh
  Abstract;
  
//model import (skGeorgeWQuidMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skGeorgeWQuidMesh ModelFile=Models\skGeorgeWQuidMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skGeorgeWQuidMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//shared anim import (skHarryQuidAnims) -AdamJD 
#exec MeshMap Scale MeshMap=skGeorgeWQuidMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skGeorgeWQuidMesh Anim=skHarryQuidAnims

//texture import (skGeorgeWQuidTex0) -AdamJD 
#exec Texture Import File=Textures\skGeorgeWQuidTex0.png Name=skGeorgeWQuidTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skGeorgeWQuidMesh Num=0 Texture=skGeorgeWQuidTex0

//texture import (skGeorgeWQuidTex1) -AdamJD 
#exec Texture Import File=Textures\skGeorgeWQuidTex1.png Name=skGeorgeWQuidTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skGeorgeWQuidMesh Num=1 Texture=skGeorgeWQuidTex1

//texture import (skGeorgeWQuidTex2) -AdamJD 
#exec Texture Import File=Textures\skGeorgeWQuidTex2.png Name=skGeorgeWQuidTex2 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skGeorgeWQuidMesh Num=2 Texture=skGeorgeWQuidTex2

//texture import (skGeorgeWQuidTex3) -AdamJD 
#exec Texture Import File=Textures\skGeorgeWQuidTex3.png Name=skGeorgeWQuidTex3 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skGeorgeWQuidMesh Num=3 Texture=skGeorgeWQuidTex3

//texture import (skGeorgeWQuidTex4) -AdamJD 
#exec Texture Import File=Textures\skGeorgeWQuidTex4.png Name=skGeorgeWQuidTex4 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skGeorgeWQuidMesh Num=4 Texture=skGeorgeWQuidTex4

