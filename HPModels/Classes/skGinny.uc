//================================================================================
// skGinny.
//================================================================================

class skGinny extends HPMesh
  Abstract;
  
//model import (skGinnyMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skGinnyMesh ModelFile=Models\skGinnyMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skGinnyMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//shared anim import (skGenFemaleAnims) -AdamJD 
#exec MeshMap Scale MeshMap=skGinnyMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skGinnyMesh Anim=skGenFemaleAnims

//texture import (skGinnyTex0) -AdamJD 
#exec Texture Import File=Textures\skGinnyTex0.png Name=skGinnyTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skGinnyMesh Num=0 Texture=skGinnyTex0

//texture import (skGinnyTex1) -AdamJD 
#exec Texture Import File=Textures\skGinnyTex1.png Name=skGinnyTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skGinnyMesh Num=1 Texture=skGinnyTex1

