//================================================================================
// skoilcan.
//================================================================================

class skoilcan extends HPMesh
  Abstract;
  
//model import (skoilcanMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skoilcanMesh ModelFile=Models\skoilcanMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skoilcanMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skoilcanAnims) -AdamJD 
#exec Anim Import Anim=skoilcanAnims AnimFile=Models\skoilcanAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skoilcanMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skoilcanMesh Anim=skoilcanAnims
#exec Anim Digest Anim=skoilcanAnims VERBOSE 

//texture import (skoilcanTex0) -AdamJD 
#exec Texture Import File=Textures\skoilcanTex0.png Name=skoilcanTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skoilcanMesh Num=0 Texture=skoilcanTex0

