//================================================================================
// skProfMcGonagall.
//================================================================================

class skProfMcGonagall extends HPMesh
  Abstract;
  
//model import (skProfMcGonagallMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skProfMcGonagallMesh ModelFile=Models\skProfMcGonagallMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skProfMcGonagallMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skProfMcGonagallAnims) -AdamJD 
#exec Anim Import Anim=skProfMcGonagallAnims AnimFile=Models\skProfMcGonagallAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skProfMcGonagallMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skProfMcGonagallMesh Anim=skProfMcGonagallAnims
#exec Anim Digest Anim=skProfMcGonagallAnims VERBOSE 

//texture import (skProfMcGonagallTex0) -AdamJD 
#exec Texture Import File=Textures\skProfMcGonagallTex0.png Name=skProfMcGonagallTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skProfMcGonagallMesh Num=0 Texture=skProfMcGonagallTex0

//texture import (skProfMcGonagallTex1) -AdamJD 
#exec Texture Import File=Textures\skProfMcGonagallTex1.png Name=skProfMcGonagallTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skProfMcGonagallMesh Num=1 Texture=skProfMcGonagallTex1

//texture import (skProfMcGonagallTex2) -AdamJD 
#exec Texture Import File=Textures\skProfMcGonagallTex2.png Name=skProfMcGonagallTex2 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skProfMcGonagallMesh Num=2 Texture=skProfMcGonagallTex2

//texture import (skProfMcGonagallTex3) -AdamJD 
#exec Texture Import File=Textures\skProfMcGonagallTex3.png Name=skProfMcGonagallTex3 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skProfMcGonagallMesh Num=3 Texture=skProfMcGonagallTex3

