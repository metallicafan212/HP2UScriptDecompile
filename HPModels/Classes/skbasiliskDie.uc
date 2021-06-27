//================================================================================
// skbasiliskDie.
//================================================================================

class skbasiliskDie extends HPMesh
  Abstract;
  
//model import (skbasiliskDieMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skbasiliskDieMesh ModelFile=Models\skbasiliskDieMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skbasiliskDieMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skbasiliskDieAnims) -AdamJD 
#exec Anim Import Anim=skbasiliskDieAnims AnimFile=Models\skbasiliskDieAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skbasiliskDieMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skbasiliskDieMesh Anim=skbasiliskDieAnims
#exec Anim Digest Anim=skbasiliskDieAnims VERBOSE 

//texture import (skbasiliskDieTex0) -AdamJD 
#exec Texture Import File=Textures\skbasiliskDieTex0.png Name=skbasiliskDieTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skbasiliskDieMesh Num=0 Texture=skbasiliskDieTex0

//texture import (skbasiliskDieTex1) -AdamJD 
#exec Texture Import File=Textures\skbasiliskDieTex1.png Name=skbasiliskDieTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skbasiliskDieMesh Num=1 Texture=skbasiliskDieTex1

//texture import (skbasiliskDieTex2) -AdamJD 
#exec Texture Import File=Textures\skbasiliskDieTex2.png Name=skbasiliskDieTex2 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skbasiliskDieMesh Num=2 Texture=skbasiliskDieTex2

//texture import (skbasiliskDieTex3) -AdamJD 
#exec Texture Import File=Textures\skbasiliskDieTex3.png Name=skbasiliskDieTex3 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skbasiliskDieMesh Num=3 Texture=skbasiliskDieTex3

//texture import (skbasiliskDieTex4) -AdamJD 
#exec Texture Import File=Textures\skbasiliskDieTex4.png Name=skbasiliskDieTex4 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skbasiliskDieMesh Num=4 Texture=skbasiliskDieTex4

