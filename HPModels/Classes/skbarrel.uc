//================================================================================
// skbarrel.
//================================================================================

class skbarrel extends HPMesh
  Abstract;
  
//model import (skbarrelMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skbarrelMesh ModelFile=Models\skbarrelMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skbarrelMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skbarrelAnims) -AdamJD 
#exec Anim Import Anim=skbarrelAnims AnimFile=Models\skbarrelAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skbarrelMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skbarrelMesh Anim=skbarrelAnims
#exec Anim Digest Anim=skbarrelAnims VERBOSE 

//texture import (skbarrelTex0) -AdamJD 
#exec Texture Import File=Textures\skbarrelTex0.png Name=skbarrelTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skbarrelMesh Num=0 Texture=skbarrelTex0

