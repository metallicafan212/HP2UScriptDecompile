//================================================================================
// skorangesnail.
//================================================================================

class skorangesnail extends HPMesh
  Abstract;
  
//model import (skorangesnailMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skorangesnailMesh ModelFile=Models\skorangesnailMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skorangesnailMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skorangesnailAnims) -AdamJD 
#exec Anim Import Anim=skorangesnailAnims AnimFile=Models\skorangesnailAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skorangesnailMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skorangesnailMesh Anim=skorangesnailAnims
#exec Anim Digest Anim=skorangesnailAnims VERBOSE 

//texture import (skorangesnailTex0) -AdamJD 
#exec Texture Import File=Textures\skorangesnailTex0.png Name=skorangesnailTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skorangesnailMesh Num=0 Texture=skorangesnailTex0

