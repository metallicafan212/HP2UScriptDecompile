//================================================================================
// skLockHarry.
//================================================================================

class skLockHarry extends HPMesh
  Abstract;
  
//model import (skLockHarryMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skLockHarryMesh ModelFile=Models\skLockHarryMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skLockHarryMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skLockHarryAnims) -AdamJD 
#exec Anim Import Anim=skLockHarryAnims AnimFile=Models\skLockHarryAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skLockHarryMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skLockHarryMesh Anim=skLockHarryAnims
#exec Anim Digest Anim=skLockHarryAnims VERBOSE 

//texture import (skLockHarryTex0) -AdamJD 
#exec Texture Import File=Textures\skLockHarryTex0.png Name=skLockHarryTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skLockHarryMesh Num=0 Texture=skLockHarryTex0

//texture import (skLockHarryTex1) -AdamJD 
#exec Texture Import File=Textures\skLockHarryTex1.png Name=skLockHarryTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skLockHarryMesh Num=1 Texture=skLockHarryTex1

//texture import (skLockHarryTex2) -AdamJD 
#exec Texture Import File=Textures\skLockHarryTex2.png Name=skLockHarryTex2 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skLockHarryMesh Num=2 Texture=skLockHarryTex2

//texture import (skLockHarryTex3) -AdamJD 
#exec Texture Import File=Textures\skLockHarryTex3.png Name=skLockHarryTex3 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skLockHarryMesh Num=3 Texture=skLockHarryTex3

//texture import (skLockHarryTex4) -AdamJD 
#exec Texture Import File=Textures\skLockHarryTex4.png Name=skLockHarryTex4 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skLockHarryMesh Num=4 Texture=skLockHarryTex4

//texture import (skLockHarryTex5) -AdamJD 
#exec Texture Import File=Textures\skLockHarryTex5.png Name=skLockHarryTex5 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skLockHarryMesh Num=5 Texture=skLockHarryTex5

