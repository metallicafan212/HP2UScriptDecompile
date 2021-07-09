//================================================================================
// skGinnyPrivet.
//================================================================================

class skGinnyPrivet extends HPMesh
  Abstract;
  
//model import (skGinnyPrivetMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skGinnyPrivetMesh ModelFile=Models\skGinnyPrivetMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skGinnyPrivetMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skGinnyPrivetAnims) -AdamJD 
#exec Anim Import Anim=skGinnyPrivetAnims AnimFile=Models\skGinnyPrivetAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skGinnyPrivetMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skGinnyPrivetMesh Anim=skGinnyPrivetAnims
#exec Anim Digest Anim=skGinnyPrivetAnims VERBOSE 

//texture import (skGinnyPrivetTex0) -AdamJD 
#exec Texture Import File=Textures\skGinnyPrivetTex0.png Name=skGinnyPrivetTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skGinnyPrivetMesh Num=0 Texture=skGinnyPrivetTex0

//texture import (skGinnyPrivetTex1) -AdamJD 
#exec Texture Import File=Textures\skGinnyPrivetTex1.png Name=skGinnyPrivetTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skGinnyPrivetMesh Num=1 Texture=skGinnyPrivetTex1

//texture import (skGinnyPrivetTex2) -AdamJD 
#exec Texture Import File=Textures\skGinnyPrivetTex2.png Name=skGinnyPrivetTex2 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skGinnyPrivetMesh Num=2 Texture=skGinnyPrivetTex2

//texture import (skGinnyPrivetTex3) -AdamJD 
#exec Texture Import File=Textures\skGinnyPrivetTex3.png Name=skGinnyPrivetTex3 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skGinnyPrivetMesh Num=3 Texture=skGinnyPrivetTex3

