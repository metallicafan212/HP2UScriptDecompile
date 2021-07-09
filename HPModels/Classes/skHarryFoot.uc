//================================================================================
// skHarryFoot.
//================================================================================

class skHarryFoot extends HPMesh
  Abstract;
  
//model import (skHarryFootMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skHarryFootMesh ModelFile=Models\skHarryFootMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skHarryFootMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skHarryFootAnims) -AdamJD 
#exec Anim Import Anim=skHarryFootAnims AnimFile=Models\skHarryFootAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skHarryFootMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skHarryFootMesh Anim=skHarryFootAnims
#exec Anim Digest Anim=skHarryFootAnims VERBOSE 

//texture import (skHarryFootTex0) -AdamJD 
#exec Texture Import File=Textures\skHarryFootTex0.png Name=skHarryFootTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHarryFootMesh Num=0 Texture=skHarryFootTex0

//texture import (skHarryFootTex1) -AdamJD 
#exec Texture Import File=Textures\skHarryFootTex1.png Name=skHarryFootTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHarryFootMesh Num=1 Texture=skHarryFootTex1

