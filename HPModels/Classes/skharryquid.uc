//================================================================================
// skharryquid.
//================================================================================

class skharryquid extends HPMesh
  Abstract;
  
//model import (skharryquidMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skharryquidMesh ModelFile=Models\skharryquidMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skharryquidMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//shared anim import (skHarryQuidAnims) -AdamJD 
#exec MeshMap Scale MeshMap=skHarryQuidMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skHarryQuidMesh Anim=skHarryQuidAnims

//texture import (skharryquidTex0) -AdamJD 
#exec Texture Import File=Textures\skharryquidTex0.png Name=skharryquidTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skharryquidMesh Num=0 Texture=skharryquidTex0

//texture import (skharryquidTex1) -AdamJD 
#exec Texture Import File=Textures\skharryquidTex1.png Name=skharryquidTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skharryquidMesh Num=1 Texture=skharryquidTex1

//texture import (skharryquidTex2) -AdamJD 
#exec Texture Import File=Textures\skharryquidTex2.png Name=skharryquidTex2 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skharryquidMesh Num=2 Texture=skharryquidTex2

//texture import (skharryquidTex3) -AdamJD 
#exec Texture Import File=Textures\skharryquidTex3.png Name=skharryquidTex3 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skharryquidMesh Num=3 Texture=skharryquidTex3

//texture import (skharryquidTex4) -AdamJD 
#exec Texture Import File=Textures\skharryquidTex4.png Name=skharryquidTex4 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skharryquidMesh Num=4 Texture=skharryquidTex4


