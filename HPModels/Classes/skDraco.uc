//================================================================================
// skDraco.
//================================================================================

class skDraco extends HPMesh
  Abstract;
  
//model import (skDracoMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skDracoMesh ModelFile=Models\skDracoMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skDracoMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//shared anim import (skGenMaleAnims) -AdamJD 
#exec MeshMap Scale MeshMap=skDracoMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skDracoMesh Anim=skGenMaleAnims

//texture import (skDracoTex0) -AdamJD 
#exec Texture Import File=Textures\skDracoTex0.png Name=skDracoTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skDracoMesh Num=0 Texture=skDracoTex0

//texture import (skDracoTex1) -AdamJD 
#exec Texture Import File=Textures\skDracoTex1.png Name=skDracoTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skDracoMesh Num=1 Texture=skDracoTex1

//texture import (skDracoTex2) -AdamJD 
#exec Texture Import File=Textures\skDracoTex2.png Name=skDracoTex2 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skDracoMesh Num=2 Texture=skDracoTex2

//weapon import -AdamJD
#exec Mesh WeaponAttach Mesh=skDracoMesh Bone="RightHand"
#exec Mesh WeaponPosition Mesh=skDracoMesh Yaw=0 Pitch=0 Roll=10 X=0.0 Y=0.0 Z=0.0

