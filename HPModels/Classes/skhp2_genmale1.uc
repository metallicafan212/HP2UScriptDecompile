//================================================================================
// skhp2_genmale1.
//================================================================================

class skhp2_genmale1 extends HPMesh
  Abstract;
  
//model import (skhp2_genmale1Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skhp2_genmale1Mesh ModelFile=Models\skhp2_genmale1Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skhp2_genmale1Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//shared anim import (skGenMaleAnims) -AdamJD 
#exec MeshMap Scale MeshMap=skhp2_genmale1Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skhp2_genmale1Mesh Anim=skGenMaleAnims

//texture import (skhp2_genmale1_1Tex0) -AdamJD 
#exec Texture Import File=Textures\skhp2_genmale1_1Tex0.png Name=skhp2_genmale1_1Tex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 

//texture import (skhp2_genmale1_1Tex1) -AdamJD 
#exec Texture Import File=Textures\skhp2_genmale1_1Tex1.png Name=skhp2_genmale1_1Tex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 

//texture import (skhp2_genmale1_2Tex0) -AdamJD 
#exec Texture Import File=Textures\skhp2_genmale1_2Tex0.png Name=skhp2_genmale1_2Tex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 

//texture import (skhp2_genmale1_2Tex1) -AdamJD 
#exec Texture Import File=Textures\skhp2_genmale1_2Tex1.png Name=skhp2_genmale1_2Tex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 

//texture import (skhp2_genmale1_3Tex0) -AdamJD 
#exec Texture Import File=Textures\skhp2_genmale1_3Tex0.png Name=skhp2_genmale1_3Tex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 

//texture import (skhp2_genmale1_3Tex1) -AdamJD 
#exec Texture Import File=Textures\skhp2_genmale1_3Tex1.png Name=skhp2_genmale1_3Tex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 

//texture import (skhp2_genmale1_4Tex0) -AdamJD 
#exec Texture Import File=Textures\skhp2_genmale1_4Tex0.png Name=skhp2_genmale1_4Tex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 

//texture import (skhp2_genmale1_4Tex1) -AdamJD 
#exec Texture Import File=Textures\skhp2_genmale1_4Tex1.png Name=skhp2_genmale1_4Tex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 

//texture import (skhp2_genmale1_5Tex0) -AdamJD 
#exec Texture Import File=Textures\skhp2_genmale1_5Tex0.png Name=skhp2_genmale1_5Tex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 

//texture import (skhp2_genmale1_5Tex1) -AdamJD 
#exec Texture Import File=Textures\skhp2_genmale1_5Tex1.png Name=skhp2_genmale1_5Tex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 

//texture import (skhp2_genmale1_6Tex0) -AdamJD 
#exec Texture Import File=Textures\skhp2_genmale1_6Tex0.png Name=skhp2_genmale1_6Tex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 

//texture import (skhp2_genmale1_6Tex1) -AdamJD 
#exec Texture Import File=Textures\skhp2_genmale1_6Tex1.png Name=skhp2_genmale1_6Tex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 

//texture import (skhp2_genmale1_7Tex0) -AdamJD 
#exec Texture Import File=Textures\skhp2_genmale1_7Tex0.png Name=skhp2_genmale1_7Tex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 

//texture import (skhp2_genmale1_7Tex1) -AdamJD 
#exec Texture Import File=Textures\skhp2_genmale1_7Tex1.png Name=skhp2_genmale1_7Tex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 

//texture import (skhp2_genmale1_0Tex0) -AdamJD 
#exec Texture Import File=Textures\skhp2_genmale1_0Tex0.png Name=skhp2_genmale1_0Tex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skhp2_genmale1Mesh Num=0 Texture=skhp2_genmale1_0Tex0

//texture import (skhp2_genmale1_0Tex1) -AdamJD 
#exec Texture Import File=Textures\skhp2_genmale1_0Tex1.png Name=skhp2_genmale1_0Tex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skhp2_genmale1Mesh Num=1 Texture=skhp2_genmale1_0Tex1

//weapon import -AdamJD
#exec Mesh WeaponAttach Mesh=skhp2_genmale1Mesh Bone="RightHand"
#exec Mesh WeaponPosition Mesh=skhp2_genmale1Mesh Yaw=0 Pitch=0 Roll=10 X=0.0 Y=0.0 Z=0.0 

