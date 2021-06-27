//================================================================================
// skAragogWebBase.
//================================================================================

class skAragogWebBase extends HPMesh
  Abstract;
  
//model import (skAragogWebBaseMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skAragogWebBaseMesh ModelFile=Models\skAragogWebBaseMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skAragogWebBaseMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skAragogWebBaseAnims) -AdamJD 
#exec Anim Import Anim=skAragogWebBaseAnims AnimFile=Models\skAragogWebBaseAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skAragogWebBaseMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skAragogWebBaseMesh Anim=skAragogWebBaseAnims
#exec Anim Digest Anim=skAragogWebBaseAnims VERBOSE 

//texture import (skAragogWebBaseTex0) -AdamJD 
#exec Texture Import File=Textures\skAragogWebBaseTex0.png Name=skAragogWebBaseTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skAragogWebBaseMesh Num=0 Texture=skAragogWebBaseTex0

