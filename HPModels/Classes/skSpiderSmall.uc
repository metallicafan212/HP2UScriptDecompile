//================================================================================
// skSpiderSmall.
//================================================================================

class skSpiderSmall extends HPMesh
  Abstract;
  
//model import (skSpiderSmallMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skSpiderSmallMesh ModelFile=Models\skSpiderSmallMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skSpiderSmallMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skSpiderSmallAnims) -AdamJD 
#exec Anim Import Anim=skSpiderSmallAnims AnimFile=Models\skSpiderSmallAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skSpiderSmallMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skSpiderSmallMesh Anim=skSpiderSmallAnims
#exec Anim Digest Anim=skSpiderSmallAnims VERBOSE 

//texture import (skSpiderSmallTex0) -AdamJD 
#exec Texture Import File=Textures\skSpiderSmallTex0.png Name=skSpiderSmallTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skSpiderSmallMesh Num=0 Texture=skSpiderSmallTex0

