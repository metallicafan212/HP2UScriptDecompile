//================================================================================
// skHagrid.
//================================================================================

class skHagrid extends HPMesh
  Abstract;
  
//model import (skHagridMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skHagridMesh ModelFile=Models\skHagridMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skHagridMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skHagridAnims) -AdamJD 
#exec Anim Import Anim=skHagridAnims AnimFile=Models\skHagridAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skHagridMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skHagridMesh Anim=skHagridAnims
#exec Anim Digest Anim=skHagridAnims VERBOSE 

//texture import (skHagridTex0) -AdamJD 
#exec Texture Import File=Textures\skHagridTex0.png Name=skHagridTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHagridMesh Num=0 Texture=skHagridTex0

//texture import (skHagridTex1) -AdamJD 
#exec Texture Import File=Textures\skHagridTex1.png Name=skHagridTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHagridMesh Num=1 Texture=skHagridTex1

