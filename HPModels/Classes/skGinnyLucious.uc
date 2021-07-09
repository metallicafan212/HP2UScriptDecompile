//================================================================================
// skGinnyLucious.
//================================================================================

class skGinnyLucious extends HPMesh
  Abstract;
  
//model import (skGinnyLuciousMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skGinnyLuciousMesh ModelFile=Models\skGinnyLuciousMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skGinnyLuciousMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skGinnyLuciousAnims) -AdamJD 
#exec Anim Import Anim=skGinnyLuciousAnims AnimFile=Models\skGinnyLuciousAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skGinnyLuciousMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skGinnyLuciousMesh Anim=skGinnyLuciousAnims
#exec Anim Digest Anim=skGinnyLuciousAnims VERBOSE 

//texture import (skGinnyLuciousTex0) -AdamJD 
#exec Texture Import File=Textures\skGinnyLuciousTex0.png Name=skGinnyLuciousTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skGinnyLuciousMesh Num=0 Texture=skGinnyLuciousTex0

//texture import (skGinnyLuciousTex1) -AdamJD 
#exec Texture Import File=Textures\skGinnyLuciousTex1.png Name=skGinnyLuciousTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skGinnyLuciousMesh Num=1 Texture=skGinnyLuciousTex1

//texture import (skGinnyLuciousTex2) -AdamJD 
#exec Texture Import File=Textures\skGinnyLuciousTex2.png Name=skGinnyLuciousTex2 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skGinnyLuciousMesh Num=2 Texture=skGinnyLuciousTex2

//texture import (skGinnyLuciousTex3) -AdamJD 
#exec Texture Import File=Textures\skGinnyLuciousTex3.png Name=skGinnyLuciousTex3 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skGinnyLuciousMesh Num=3 Texture=skGinnyLuciousTex3

//texture import (skGinnyLuciousTex4) -AdamJD 
#exec Texture Import File=Textures\skGinnyLuciousTex4.png Name=skGinnyLuciousTex4 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skGinnyLuciousMesh Num=4 Texture=skGinnyLuciousTex4

//texture import (skGinnyLuciousTex5) -AdamJD 
#exec Texture Import File=Textures\skGinnyLuciousTex5.png Name=skGinnyLuciousTex5 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skGinnyLuciousMesh Num=5 Texture=skGinnyLuciousTex5

//texture import (skGinnyLuciousTex6) -AdamJD 
#exec Texture Import File=Textures\skGinnyLuciousTex6.png Name=skGinnyLuciousTex6 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skGinnyLuciousMesh Num=6 Texture=skGinnyLuciousTex6

