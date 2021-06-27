//================================================================================
// skAragogWeb.
//================================================================================

class skAragogWeb extends HPMesh
  Abstract;
  
//model import (skAragogWebMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skAragogWebMesh ModelFile=Models\skAragogWebMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skAragogWebMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skAragogWebAnims) -AdamJD 
#exec Anim Import Anim=skAragogWebAnims AnimFile=Models\skAragogWebAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skAragogWebMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skAragogWebMesh Anim=skAragogWebAnims
#exec Anim Digest Anim=skAragogWebAnims VERBOSE 

//texture import (skAragogWebTex0) -AdamJD 
#exec Texture Import File=Textures\skAragogWebTex0.png Name=skAragogWebTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skAragogWebMesh Num=0 Texture=skAragogWebTex0

