//================================================================================
// skProfDumbledore.
//================================================================================

class skProfDumbledore extends HPMesh
  Abstract;
  
//model import (skProfDumbledoreMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skProfDumbledoreMesh ModelFile=Models\skProfDumbledoreMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skProfDumbledoreMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skProfDumbledoreAnims) -AdamJD 
#exec Anim Import Anim=skProfDumbledoreAnims AnimFile=Models\skProfDumbledoreAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skProfDumbledoreMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skProfDumbledoreMesh Anim=skProfDumbledoreAnims
#exec Anim Digest Anim=skProfDumbledoreAnims VERBOSE 

//texture import (skProfDumbledoreTex0) -AdamJD 
#exec Texture Import File=Textures\skProfDumbledoreTex0.png Name=skProfDumbledoreTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skProfDumbledoreMesh Num=0 Texture=skProfDumbledoreTex0

//texture import (skProfDumbledoreTex1) -AdamJD 
#exec Texture Import File=Textures\skProfDumbledoreTex1.png Name=skProfDumbledoreTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skProfDumbledoreMesh Num=1 Texture=skProfDumbledoreTex1

//texture import (skProfDumbledoreTex2) -AdamJD 
#exec Texture Import File=Textures\skProfDumbledoreTex2.png Name=skProfDumbledoreTex2 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skProfDumbledoreMesh Num=2 Texture=skProfDumbledoreTex2

//texture import (skProfDumbledoreTex3) -AdamJD 
#exec Texture Import File=Textures\skProfDumbledoreTex3.png Name=skProfDumbledoreTex3 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skProfDumbledoreMesh Num=3 Texture=skProfDumbledoreTex3

