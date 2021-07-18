//================================================================================
// skPerch.
//================================================================================

class skPerch extends HPMesh
  Abstract;
  
//model import (skPerchMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skPerchMesh ModelFile=Models\skPerchMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skPerchMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skPerchAnims) -AdamJD 
#exec Anim Import Anim=skPerchAnims AnimFile=Models\skPerchAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skPerchMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skPerchMesh Anim=skPerchAnims
#exec Anim Digest Anim=skPerchAnims VERBOSE 

//texture import (skPerchTex0) -AdamJD 
#exec Texture Import File=Textures\skPerchTex0.png Name=skPerchTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skPerchMesh Num=0 Texture=skPerchTex0

