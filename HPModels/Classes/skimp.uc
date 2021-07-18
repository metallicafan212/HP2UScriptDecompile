//================================================================================
// skimp.
//================================================================================

class skimp extends HPMesh
  Abstract;
  
//model import (skimpMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skimpMesh ModelFile=Models\skimpMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skimpMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skimpAnims) -AdamJD 
#exec Anim Import Anim=skimpAnims AnimFile=Models\skimpAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skimpMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skimpMesh Anim=skimpAnims
#exec Anim Digest Anim=skimpAnims VERBOSE 

//texture import (skimpTex0) -AdamJD 
#exec Texture Import File=Textures\skimpTex0.png Name=skimpTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skimpMesh Num=0 Texture=skimpTex0

