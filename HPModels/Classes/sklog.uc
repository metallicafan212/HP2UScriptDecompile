//================================================================================
// sklog.
//================================================================================

class sklog extends HPMesh
  Abstract;
  
//model import (sklogMesh) -AdamJD 
#exec Mesh ModelImport Mesh=sklogMesh ModelFile=Models\sklogMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=sklogMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (sklogAnims) -AdamJD 
#exec Anim Import Anim=sklogAnims AnimFile=Models\sklogAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=sklogMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=sklogMesh Anim=sklogAnims
#exec Anim Digest Anim=sklogAnims VERBOSE 

//texture import (sklogTex0) -AdamJD 
#exec Texture Import File=Textures\sklogTex0.png Name=sklogTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=sklogMesh Num=0 Texture=sklogTex0

