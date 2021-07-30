//================================================================================
// skron.
//================================================================================

class skron extends HPMesh
  Abstract;
  
//model import (skronMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skronMesh ModelFile=Models\skronMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skronMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//shared anim import (skGenMaleAnims) -AdamJD 
#exec MeshMap Scale MeshMap=skronMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skronMesh Anim=skGenMaleAnims 

//texture import (skronTex0) -AdamJD 
#exec Texture Import File=Textures\skronTex0.png Name=skronTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skronMesh Num=0 Texture=skronTex0

//texture import (skronTex1) -AdamJD 
#exec Texture Import File=Textures\skronTex1.png Name=skronTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skronMesh Num=1 Texture=skronTex1

//weapon import -AdamJD
#exec Mesh WeaponAttach Mesh=skronMesh Bone="RightHand"
#exec Mesh WeaponPosition Mesh=skronMesh Yaw=0 Pitch=0 Roll=10 X=0.0 Y=0.0 Z=0.0

