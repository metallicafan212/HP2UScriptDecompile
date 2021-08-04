//================================================================================
// skpinklady.
//================================================================================

class skpinklady extends HPMesh
  Abstract;
  
//model import (skpinkladyMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skpinkladyMesh ModelFile=Models\skpinkladyMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skpinkladyMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skpinkladyAnims) -AdamJD 
#exec Anim Import Anim=skpinkladyAnims AnimFile=Models\skpinkladyAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skpinkladyMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skpinkladyMesh Anim=skpinkladyAnims
#exec Anim Digest Anim=skpinkladyAnims VERBOSE 

//texture import (skpinkladyTex0) -AdamJD 
#exec Texture Import File=Textures\skpinkladyTex0.png Name=skpinkladyTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skpinkladyMesh Num=0 Texture=skpinkladyTex0

//texture import (skpinkladyTex1) -AdamJD 
#exec Texture Import File=Textures\skpinkladyTex1.png Name=skpinkladyTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skpinkladyMesh Num=1 Texture=skpinkladyTex1

//texture import (skpinkladyTex2) -AdamJD 
#exec Texture Import File=Textures\skpinkladyTex2.png Name=skpinkladyTex2 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skpinkladyMesh Num=2 Texture=skpinkladyTex2


