//================================================================================
// skhermione.
//================================================================================

class skhermione extends HPMesh
  Abstract;
  
//model import (skhermioneMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skhermioneMesh ModelFile=Models\skhermioneMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skhermioneMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//shared anim import (skGenFemaleAnims) -AdamJD 
#exec MeshMap Scale MeshMap=skhermioneMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skhermioneMesh Anim=skGenFemaleAnims

//texture import (skhermioneTex0) -AdamJD 
#exec Texture Import File=Textures\skhermioneTex0.png Name=skhermioneTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skhermioneMesh Num=0 Texture=skhermioneTex0

//texture import (skhermioneTex1) -AdamJD 
#exec Texture Import File=Textures\skhermioneTex1.png Name=skhermioneTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skhermioneMesh Num=1 Texture=skhermioneTex1

//texture import (skhermioneTex2) -AdamJD 
#exec Texture Import File=Textures\skhermioneTex2.png Name=skhermioneTex2 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skhermioneMesh Num=2 Texture=skhermioneTex2

//weapon import -AdamJD
#exec Mesh WeaponAttach Mesh=skhermioneMesh Bone="RightHand"
#exec Mesh WeaponPosition Mesh=skhermioneMesh Yaw=0 Pitch=0 Roll=10 X=0.0 Y=0.0 Z=0.0

