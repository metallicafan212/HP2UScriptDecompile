//================================================================================
// skSpongifyRug.
//================================================================================

class skSpongifyRug extends HPMesh
  Abstract;
  
//model import (skSpongifyRugMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skSpongifyRugMesh ModelFile=Models\skSpongifyRugMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skSpongifyRugMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skSpongifyRugAnims) -AdamJD 
#exec Anim Import Anim=skSpongifyRugAnims AnimFile=Models\skSpongifyRugAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skSpongifyRugMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skSpongifyRugMesh Anim=skSpongifyRugAnims
#exec Anim Digest Anim=skSpongifyRugAnims VERBOSE 

//texture import (skSpongifyRugTex0) -AdamJD 
#exec Texture Import File=Textures\skSpongifyRugTex0.png Name=skSpongifyRugTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skSpongifyRugMesh Num=0 Texture=skSpongifyRugTex0


