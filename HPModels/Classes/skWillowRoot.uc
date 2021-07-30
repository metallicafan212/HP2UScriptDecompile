//================================================================================
// skWillowRoot.
//================================================================================

class skWillowRoot extends HPMesh
  Abstract;
  
//model import (skWillowRootMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skWillowRootMesh ModelFile=Models\skWillowRootMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skWillowRootMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skWillowRootAnims) -AdamJD 
#exec Anim Import Anim=skWillowRootAnims AnimFile=Models\skWillowRootAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skWillowRootMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skWillowRootMesh Anim=skWillowRootAnims
#exec Anim Digest Anim=skWillowRootAnims VERBOSE 

//texture import (skWillowRootTex0) -AdamJD 
#exec Texture Import File=Textures\skWillowRootTex0.png Name=skWillowRootTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skWillowRootMesh Num=0 Texture=skWillowRootTex0

//texture import (skWillowRootTex1) -AdamJD 
#exec Texture Import File=Textures\skWillowRootTex1.png Name=skWillowRootTex1 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skWillowRootMesh Num=1 Texture=skWillowRootTex1

