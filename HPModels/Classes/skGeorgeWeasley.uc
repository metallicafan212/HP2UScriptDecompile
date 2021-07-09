//================================================================================
// skGeorgeWeasley.
//================================================================================

class skGeorgeWeasley extends HPMesh
  Abstract;
  
//model import (skGeorgeWeasleyMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skGeorgeWeasleyMesh ModelFile=Models\skGeorgeWeasleyMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skGeorgeWeasleyMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//shared anim import (skGeorgeWeasleyAnims) -AdamJD 
#exec MeshMap Scale MeshMap=skGeorgeWeasleyMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skGeorgeWeasleyMesh Anim=skGeorgeWeasleyAnims

//texture import (skGeorgeWeasleyTex0) -AdamJD 
#exec Texture Import File=Textures\skGeorgeWeasleyTex0.png Name=skGeorgeWeasleyTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skGeorgeWeasleyMesh Num=0 Texture=skGeorgeWeasleyTex0

//texture import (skGeorgeWeasleyTex1) -AdamJD 
#exec Texture Import File=Textures\skGeorgeWeasleyTex1.png Name=skGeorgeWeasleyTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skGeorgeWeasleyMesh Num=1 Texture=skGeorgeWeasleyTex1

//weapon import -AdamJD
#exec Mesh WeaponAttach Mesh=skGeorgeWeasleyMesh Bone="RightHand"
#exec Mesh WeaponPosition Mesh=skGeorgeWeasleyMesh Yaw=0 Pitch=0 Roll=10 X=0.0 Y=0.0 Z=0.0

