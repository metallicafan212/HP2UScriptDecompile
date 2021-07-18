//================================================================================
// skProfSprout.
//================================================================================

class skProfSprout extends HPMesh
  Abstract;
  
//model import (skProfSproutMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skProfSproutMesh ModelFile=Models\skProfSproutMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skProfSproutMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skProfSproutAnims) -AdamJD 
#exec Anim Import Anim=skProfSproutAnims AnimFile=Models\skProfSproutAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skProfSproutMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skProfSproutMesh Anim=skProfSproutAnims
#exec Anim Digest Anim=skProfSproutAnims VERBOSE 

//texture import (skProfSproutTex0) -AdamJD 
#exec Texture Import File=Textures\skProfSproutTex0.png Name=skProfSproutTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skProfSproutMesh Num=0 Texture=skProfSproutTex0

//texture import (skProfSproutTex1) -AdamJD 
#exec Texture Import File=Textures\skProfSproutTex1.png Name=skProfSproutTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skProfSproutMesh Num=1 Texture=skProfSproutTex1

