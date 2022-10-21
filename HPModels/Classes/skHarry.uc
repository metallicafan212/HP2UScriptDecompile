//================================================================================
// skHarry.
//================================================================================

class skHarry extends HPMesh
  Abstract;
  
//model import (skharryMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skharryMesh ModelFile=Models\skharryMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skharryMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//shared anim import (skHarryAnims) -AdamJD 
#exec MeshMap Scale MeshMap=skHarryMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skHarryMesh Anim=skHarryAnims

//texture import (skharryTex0) -AdamJD 
#exec Texture Import File=Textures\skharryTex0.png Name=skharryTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skharryMesh Num=0 Texture=skharryTex0

//texture import (skharryTex1) -AdamJD 
#exec Texture Import File=Textures\skharryTex1.png Name=skharryTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skharryMesh Num=1 Texture=skharryTex1

//texture import (skharryTex2) -AdamJD 
#exec Texture Import File=Textures\skharryTex2.png Name=skharryTex2 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skharryMesh Num=2 Texture=skharryTex2

//texture import (skharryTex3) -AdamJD 
#exec Texture Import File=Textures\skharryTex3.png Name=skharryTex3 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skharryMesh Num=3 Texture=skharryTex3

//weapon import -AdamJD
#exec Mesh WeaponAttach Mesh=skHarryMesh Bone="RightHand"
#exec Mesh WeaponPosition Mesh=skHarryMesh Yaw=0 Pitch=0 Roll=10 X=0.0 Y=0.0 Z=0.0 

