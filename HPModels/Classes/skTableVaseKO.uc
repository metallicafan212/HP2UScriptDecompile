//================================================================================
// skTableVaseKO.
//================================================================================

class skTableVaseKO extends HPMesh
  Abstract;
  
//model import (skTableVaseKOMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skTableVaseKOMesh ModelFile=Models\skTableVaseKOMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skTableVaseKOMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skTableVaseKOAnims) -AdamJD 
#exec Anim Import Anim=skTableVaseKOAnims AnimFile=Models\skTableVaseKOAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skTableVaseKOMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skTableVaseKOMesh Anim=skTableVaseKOAnims
#exec Anim Digest Anim=skTableVaseKOAnims VERBOSE 

//texture import (skTableVaseKOTex0) -AdamJD 
#exec Texture Import File=Textures\skTableVaseKOTex0.png Name=skTableVaseKOTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skTableVaseKOMesh Num=0 Texture=skTableVaseKOTex0

//texture import (skTableVaseKOTex1) -AdamJD 
#exec Texture Import File=Textures\skTableVaseKOTex1.png Name=skTableVaseKOTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skTableVaseKOMesh Num=1 Texture=skTableVaseKOTex1

