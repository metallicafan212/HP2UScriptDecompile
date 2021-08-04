//================================================================================
// skFredWeasley.
//================================================================================

class skFredWeasley extends HPMesh
  Abstract;
  
//model import (skFredWeasleyMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skFredWeasleyMesh ModelFile=Models\skFredWeasleyMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skFredWeasleyMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//shared anim import (skGeorgeWeasleyAnims) -AdamJD 
#exec MeshMap Scale MeshMap=skFredWeasleyMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skFredWeasleyMesh Anim=skGeorgeWeasleyAnims

//texture import (skFredWeasleyTex0) -AdamJD 
#exec Texture Import File=Textures\skFredWeasleyTex0.png Name=skFredWeasleyTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFredWeasleyMesh Num=0 Texture=skFredWeasleyTex0

//texture import (skFredWeasleyTex1) -AdamJD 
#exec Texture Import File=Textures\skFredWeasleyTex1.png Name=skFredWeasleyTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFredWeasleyMesh Num=1 Texture=skFredWeasleyTex1

//weapon import -AdamJD
#exec Mesh WeaponAttach Mesh=skFredWeasleyMesh Bone="RightHand"
#exec Mesh WeaponPosition Mesh=skFredWeasleyMesh Yaw=0 Pitch=0 Roll=10 X=0.0 Y=0.0 Z=0.0

