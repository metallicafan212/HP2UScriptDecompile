//================================================================================
// skHarryIsGoyle.
//================================================================================

class skHarryIsGoyle extends HPMesh
  Abstract;
  
//model import (skHarryIsGoyleMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skHarryIsGoyleMesh ModelFile=Models\skHarryIsGoyleMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skHarryIsGoyleMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skHarryIsGoyleAnims) -AdamJD 
#exec Anim Import Anim=skHarryIsGoyleAnims AnimFile=Models\skHarryIsGoyleAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skHarryIsGoyleMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skHarryIsGoyleMesh Anim=skHarryIsGoyleAnims
#exec Anim Digest Anim=skHarryIsGoyleAnims VERBOSE 

//texture import (skHarryIsGoyleTex0) -AdamJD 
#exec Texture Import File=Textures\skHarryIsGoyleTex0.png Name=skHarryIsGoyleTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHarryIsGoyleMesh Num=0 Texture=skHarryIsGoyleTex0

//texture import (skHarryIsGoyleTex1) -AdamJD 
#exec Texture Import File=Textures\skHarryIsGoyleTex1.png Name=skHarryIsGoyleTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHarryIsGoyleMesh Num=1 Texture=skHarryIsGoyleTex1

//texture import (skHarryIsGoyleTex2) -AdamJD 
#exec Texture Import File=Textures\skHarryIsGoyleTex2.png Name=skHarryIsGoyleTex2 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHarryIsGoyleMesh Num=2 Texture=skHarryIsGoyleTex2

