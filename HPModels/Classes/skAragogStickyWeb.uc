//================================================================================
// skAragogStickyWeb.
//================================================================================

class skAragogStickyWeb extends HPMesh
  Abstract;
  
//model import (skAragogStickyWebMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skAragogStickyWebMesh ModelFile=Models\skAragogStickyWebMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skAragogStickyWebMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skAragogStickyWebAnims) -AdamJD 
#exec Anim Import Anim=skAragogStickyWebAnims AnimFile=Models\skAragogStickyWebAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skAragogStickyWebMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skAragogStickyWebMesh Anim=skAragogStickyWebAnims
#exec Anim Digest Anim=skAragogStickyWebAnims VERBOSE 

//texture import (skAragogStickyWebTex0) -AdamJD 
#exec Texture Import File=Textures\skAragogStickyWebTex0.png Name=skAragogStickyWebTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skAragogStickyWebMesh Num=0 Texture=skAragogStickyWebTex0

