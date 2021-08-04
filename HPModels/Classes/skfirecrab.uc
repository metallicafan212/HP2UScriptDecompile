//================================================================================
// skfirecrab.
//================================================================================

class skfirecrab extends HPMesh
  Abstract;
  
//model import (skfirecrabMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skfirecrabMesh ModelFile=Models\skfirecrabMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skfirecrabMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skfirecrabAnims) -AdamJD 
#exec Anim Import Anim=skfirecrabAnims AnimFile=Models\skfirecrabAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skfirecrabMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skfirecrabMesh Anim=skfirecrabAnims
#exec Anim Digest Anim=skfirecrabAnims VERBOSE 

//texture import (skfirecrabTex0) -AdamJD 
#exec Texture Import File=Textures\skfirecrabTex0.png Name=skfirecrabTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skfirecrabMesh Num=0 Texture=skfirecrabTex0

//texture import (skfirecrabTex1) -AdamJD 
#exec Texture Import File=Textures\skfirecrabTex1.png Name=skfirecrabTex1 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skfirecrabMesh Num=1 Texture=skfirecrabTex1

