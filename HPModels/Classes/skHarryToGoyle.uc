//================================================================================
// skHarryToGoyle.
//================================================================================

class skHarryToGoyle extends HPMesh
  Abstract;
  
//model import (skHarryToGoyleMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skHarryToGoyleMesh ModelFile=Models\skHarryToGoyleMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skHarryToGoyleMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skHarryToGoyleAnims) -AdamJD 
#exec Anim Import Anim=skHarryToGoyleAnims AnimFile=Models\skHarryToGoyleAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skHarryToGoyleMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skHarryToGoyleMesh Anim=skHarryToGoyleAnims
#exec Anim Digest Anim=skHarryToGoyleAnims VERBOSE 

//texture import (skHarryToGoyleTex0) -AdamJD 
#exec Texture Import File=Textures\skHarryToGoyleTex0.png Name=skHarryToGoyleTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHarryToGoyleMesh Num=0 Texture=skHarryToGoyleTex0

//texture import (skHarryToGoyleTex1) -AdamJD 
#exec Texture Import File=Textures\skHarryToGoyleTex1.png Name=skHarryToGoyleTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHarryToGoyleMesh Num=1 Texture=skHarryToGoyleTex1

//texture import (skHarryToGoyleTex2) -AdamJD 
#exec Texture Import File=Textures\skHarryToGoyleTex2.png Name=skHarryToGoyleTex2 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHarryToGoyleMesh Num=2 Texture=skHarryToGoyleTex2

//texture import (skHarryToGoyleTex3) -AdamJD 
#exec Texture Import File=Textures\skHarryToGoyleTex3.png Name=skHarryToGoyleTex3 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHarryToGoyleMesh Num=3 Texture=skHarryToGoyleTex3

//texture import (skHarryToGoyleTex4) -AdamJD 
#exec Texture Import File=Textures\skHarryToGoyleTex4.png Name=skHarryToGoyleTex4 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHarryToGoyleMesh Num=4 Texture=skHarryToGoyleTex4

