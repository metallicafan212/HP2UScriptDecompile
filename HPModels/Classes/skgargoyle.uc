//================================================================================
// skgargoyle.
//================================================================================

class skgargoyle extends HPMesh
  Abstract;
  
//model import (skgargoyleMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skgargoyleMesh ModelFile=Models\skgargoyleMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skgargoyleMesh X=0 Y=0 Z=30 Yaw=0 Pitch=0 Roll=0 

//anim import (skgargoyleAnims) -AdamJD 
#exec Anim Import Anim=skgargoyleAnims AnimFile=Models\skgargoyleAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skgargoyleMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skgargoyleMesh Anim=skgargoyleAnims
#exec Anim Digest Anim=skgargoyleAnims VERBOSE 

//texture import (skgargoyleTex0) -AdamJD 
#exec Texture Import File=Textures\skgargoyleTex0.png Name=skgargoyleTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skgargoyleMesh Num=0 Texture=skgargoyleTex0

