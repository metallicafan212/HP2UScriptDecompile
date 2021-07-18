//================================================================================
// skowlbarn.
//================================================================================

class skowlbarn extends HPMesh
  Abstract;
  
//model import (skowlbarnMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skowlbarnMesh ModelFile=Models\skowlbarnMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skowlbarnMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skowlbarnAnims) -AdamJD 
#exec Anim Import Anim=skowlbarnAnims AnimFile=Models\skowlbarnAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skowlbarnMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skowlbarnMesh Anim=skowlbarnAnims
#exec Anim Digest Anim=skowlbarnAnims VERBOSE 

//texture import (skowlbarnTex0) -AdamJD 
#exec Texture Import File=Textures\skowlbarnTex0.png Name=skowlbarnTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skowlbarnMesh Num=0 Texture=skowlbarnTex0

