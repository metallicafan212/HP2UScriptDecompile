//================================================================================
// skOliverWoodQuid.
//================================================================================

class skOliverWoodQuid extends HPMesh
  Abstract;
  
//model import (skOliverWoodQuidMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skOliverWoodQuidMesh ModelFile=Models\skOliverWoodQuidMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skOliverWoodQuidMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//shared anim import (skHarryQuidAnims) -AdamJD 
#exec MeshMap Scale MeshMap=skOliverWoodQuidMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skOliverWoodQuidMesh Anim=skHarryQuidAnims

//texture import (skOliverWoodQuidTex0) -AdamJD 
#exec Texture Import File=Textures\skOliverWoodQuidTex0.png Name=skOliverWoodQuidTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skOliverWoodQuidMesh Num=0 Texture=skOliverWoodQuidTex0

//texture import (skOliverWoodQuidTex1) -AdamJD 
#exec Texture Import File=Textures\skOliverWoodQuidTex1.png Name=skOliverWoodQuidTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skOliverWoodQuidMesh Num=1 Texture=skOliverWoodQuidTex1

//texture import (skOliverWoodQuidTex2) -AdamJD 
#exec Texture Import File=Textures\skOliverWoodQuidTex2.png Name=skOliverWoodQuidTex2 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skOliverWoodQuidMesh Num=2 Texture=skOliverWoodQuidTex2

//texture import (skOliverWoodQuidTex3) -AdamJD 
#exec Texture Import File=Textures\skOliverWoodQuidTex3.png Name=skOliverWoodQuidTex3 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skOliverWoodQuidMesh Num=3 Texture=skOliverWoodQuidTex3

//texture import (skOliverWoodQuidTex4) -AdamJD 
#exec Texture Import File=Textures\skOliverWoodQuidTex4.png Name=skOliverWoodQuidTex4 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skOliverWoodQuidMesh Num=4 Texture=skOliverWoodQuidTex4

