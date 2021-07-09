//================================================================================
// skdobby.
//================================================================================

class skdobby extends HPMesh
  Abstract;
  
//model import (skdobbyMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skdobbyMesh ModelFile=Models\skdobbyMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skdobbyMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skdobbyAnims) -AdamJD 
#exec Anim Import Anim=skdobbyAnims AnimFile=Models\skdobbyAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skdobbyMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skdobbyMesh Anim=skdobbyAnims
#exec Anim Digest Anim=skdobbyAnims USERAWINFO VERBOSE 

//texture import (skdobbyTex0) -AdamJD 
#exec Texture Import File=Textures\skdobbyTex0.png Name=skdobbyTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skdobbyMesh Num=0 Texture=skdobbyTex0

//texture import (skdobbyTex1) -AdamJD 
#exec Texture Import File=Textures\skdobbyTex1.png Name=skdobbyTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skdobbyMesh Num=1 Texture=skdobbyTex1

