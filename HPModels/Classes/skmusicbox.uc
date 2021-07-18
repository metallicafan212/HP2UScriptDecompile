//================================================================================
// skmusicbox.
//================================================================================

class skmusicbox extends HPMesh
  Abstract;
  
//model import (skmusicboxMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skmusicboxMesh ModelFile=Models\skmusicboxMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skmusicboxMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skmusicboxAnims) -AdamJD 
#exec Anim Import Anim=skmusicboxAnims AnimFile=Models\skmusicboxAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skmusicboxMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skmusicboxMesh Anim=skmusicboxAnims
#exec Anim Digest Anim=skmusicboxAnims VERBOSE 

//texture import (skmusicboxTex0) -AdamJD 
#exec Texture Import File=Textures\skmusicboxTex0.png Name=skmusicboxTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skmusicboxMesh Num=0 Texture=skmusicboxTex0

//texture import (skmusicboxTex1) -AdamJD 
#exec Texture Import File=Textures\skmusicboxTex1.png Name=skmusicboxTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skmusicboxMesh Num=1 Texture=skmusicboxTex1

