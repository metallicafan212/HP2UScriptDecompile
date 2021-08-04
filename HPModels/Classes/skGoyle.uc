//================================================================================
// skGoyle.
//================================================================================

class skGoyle extends HPMesh
  Abstract;
  
//model import (skGoyleMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skGoyleMesh ModelFile=Models\skGoyleMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skGoyleMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//shared anim import (skHarryAnims) -AdamJD 
#exec MeshMap Scale MeshMap=skGoyleMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skGoyleMesh Anim=skHarryAnims

//texture import (skGoyleTex0) -AdamJD 
#exec Texture Import File=Textures\skGoyleTex0.png Name=skGoyleTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skGoyleMesh Num=0 Texture=skGoyleTex0

//texture import (skGoyleTex1) -AdamJD 
#exec Texture Import File=Textures\skGoyleTex1.png Name=skGoyleTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skGoyleMesh Num=1 Texture=skGoyleTex1

//weapon import -AdamJD
#exec Mesh WeaponAttach Mesh=skGoyleMesh Bone="RightHand"
#exec Mesh WeaponPosition Mesh=skGoyleMesh Yaw=0 Pitch=0 Roll=10 X=0.0 Y=0.0 Z=0.0

