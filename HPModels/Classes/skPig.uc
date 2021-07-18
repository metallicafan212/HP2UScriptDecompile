//================================================================================
// skPig.
//================================================================================

class skPig extends HPMesh
  Abstract;
  
//model import (skPigMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skPigMesh ModelFile=Models\skPigMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skPigMesh X=10 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skPigAnims) -AdamJD 
#exec Anim Import Anim=skPigAnims AnimFile=Models\skPigAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skPigMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skPigMesh Anim=skPigAnims
#exec Anim Digest Anim=skPigAnims VERBOSE 

//texture import (skPigTex0) -AdamJD 
#exec Texture Import File=Textures\skPigTex0.png Name=skPigTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skPigMesh Num=0 Texture=skPigTex0

