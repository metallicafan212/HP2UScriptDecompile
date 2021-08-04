//================================================================================
// skPercy.
//================================================================================

class skPercy extends HPMesh
  Abstract;
  
//model import (skPercyMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skPercyMesh ModelFile=Models\skPercyMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skPercyMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//shared anim import (skGeorgeWeasleyAnims) -AdamJD 
#exec MeshMap Scale MeshMap=skPercyMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skPercyMesh Anim=skGeorgeWeasleyAnims

//texture import (skPercyTex0) -AdamJD 
#exec Texture Import File=Textures\skPercyTex0.png Name=skPercyTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skPercyMesh Num=0 Texture=skPercyTex0

//texture import (skPercyTex1) -AdamJD 
#exec Texture Import File=Textures\skPercyTex1.png Name=skPercyTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skPercyMesh Num=1 Texture=skPercyTex1

