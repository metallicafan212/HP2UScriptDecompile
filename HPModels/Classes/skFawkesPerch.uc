//================================================================================
// skFawkesPerch.
//================================================================================

class skFawkesPerch extends HPMesh
  Abstract;
  
//model import (skFawkesPerchMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skFawkesPerchMesh ModelFile=Models\skFawkesPerchMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skFawkesPerchMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skFawkesPerchAnims) -AdamJD 
#exec Anim Import Anim=skFawkesPerchAnims AnimFile=Models\skFawkesPerchAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skFawkesPerchMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skFawkesPerchMesh Anim=skFawkesPerchAnims
#exec Anim Digest Anim=skFawkesPerchAnims VERBOSE 

//texture import (skFawkesPerchTex0) -AdamJD 
#exec Texture Import File=Textures\skFawkesPerchTex0.png Name=skFawkesPerchTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFawkesPerchMesh Num=0 Texture=skFawkesPerchTex0

//texture import (skFawkesPerchTex1) -AdamJD 
#exec Texture Import File=Textures\skFawkesPerchTex1.png Name=skFawkesPerchTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFawkesPerchMesh Num=1 Texture=skFawkesPerchTex1

