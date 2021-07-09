//================================================================================
// skDracoQuid.
//================================================================================

class skDracoQuid extends HPMesh
  Abstract;
  
//model import (skDracoQuidMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skDracoQuidMesh ModelFile=Models\skDracoQuidMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skDracoQuidMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//shared anim import (skHarryQuidAnims) -AdamJD 
#exec MeshMap Scale MeshMap=skDracoQuidMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skDracoQuidMesh Anim=skHarryQuidAnims

//texture import (skDracoQuidTex0) -AdamJD 
#exec Texture Import File=Textures\skDracoQuidTex0.png Name=skDracoQuidTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skDracoQuidMesh Num=0 Texture=skDracoQuidTex0

//texture import (skDracoQuidTex1) -AdamJD 
#exec Texture Import File=Textures\skDracoQuidTex1.png Name=skDracoQuidTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skDracoQuidMesh Num=1 Texture=skDracoQuidTex1

//texture import (skDracoQuidTex2) -AdamJD 
#exec Texture Import File=Textures\skDracoQuidTex2.png Name=skDracoQuidTex2 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skDracoQuidMesh Num=2 Texture=skDracoQuidTex2

