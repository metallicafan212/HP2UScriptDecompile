//================================================================================
// skHarryAsGoyle.
//================================================================================

class skHarryAsGoyle extends HPMesh
  Abstract;
  
//model import (skHarryAsGoyleMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skHarryAsGoyleMesh ModelFile=Models\skHarryAsGoyleMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skHarryAsGoyleMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0

//anim import (skHarryAsGoyleAnims) -AdamJD 
#exec Anim Import Anim=skHarryAsGoyleAnims AnimFile=Models\skHarryAsGoyleAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skHarryAsGoyleMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skHarryAsGoyleMesh Anim=skHarryAsGoyleAnims
#exec Anim Digest Anim=skHarryAsGoyleAnims VERBOSE 

//texture import (skHarryAsGoyleTex0) -AdamJD 
#exec Texture Import File=Textures\skHarryAsGoyleTex0.png Name=skHarryAsGoyleTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHarryAsGoyleMesh Num=0 Texture=skHarryAsGoyleTex0

//texture import (skHarryAsGoyleTex1) -AdamJD 
#exec Texture Import File=Textures\skHarryAsGoyleTex1.png Name=skHarryAsGoyleTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHarryAsGoyleMesh Num=1 Texture=skHarryAsGoyleTex1

//texture import (skHarryAsGoyleTex2) -AdamJD 
#exec Texture Import File=Textures\skHarryAsGoyleTex2.png Name=skHarryAsGoyleTex2 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHarryAsGoyleMesh Num=2 Texture=skHarryAsGoyleTex2

