//================================================================================
// skProfLockhart.
//================================================================================

class skProfLockhart extends HPMesh
  Abstract;
  
//model import (skProfLockhartMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skProfLockhartMesh ModelFile=Models\skProfLockhartMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skProfLockhartMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skProfLockhartAnims) -AdamJD 
#exec Anim Import Anim=skProfLockhartAnims AnimFile=Models\skProfLockhartAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skProfLockhartMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skProfLockhartMesh Anim=skProfLockhartAnims
#exec Anim Digest Anim=skProfLockhartAnims VERBOSE 

//texture import (skProfLockhartTex0) -AdamJD 
#exec Texture Import File=Textures\skProfLockhartTex0.png Name=skProfLockhartTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skProfLockhartMesh Num=0 Texture=skProfLockhartTex0

//texture import (skProfLockhartTex1) -AdamJD 
#exec Texture Import File=Textures\skProfLockhartTex1.png Name=skProfLockhartTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skProfLockhartMesh Num=1 Texture=skProfLockhartTex1

