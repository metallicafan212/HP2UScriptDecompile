//================================================================================
// skdumbledore.
//================================================================================

class skdumbledore extends HPMesh
  Abstract;
  
//model import (skdumbledoreMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skdumbledoreMesh ModelFile=Models\skdumbledoreMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skdumbledoreMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skdumbledoreAnims) -AdamJD 
#exec Anim Import Anim=skdumbledoreAnims AnimFile=Models\skdumbledoreAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skdumbledoreMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skdumbledoreMesh Anim=skdumbledoreAnims
#exec Anim Digest Anim=skdumbledoreAnims VERBOSE 

//texture import (skdumbledoreTex0) -AdamJD 
#exec Texture Import File=Textures\skdumbledoreTex0.png Name=skdumbledoreTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skdumbledoreMesh Num=0 Texture=skdumbledoreTex0

//texture import (skdumbledoreTex1) -AdamJD 
#exec Texture Import File=Textures\skdumbledoreTex1.png Name=skdumbledoreTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skdumbledoreMesh Num=1 Texture=skdumbledoreTex1

//texture import (skdumbledoreTex2) -AdamJD 
#exec Texture Import File=Textures\skdumbledoreTex2.png Name=skdumbledoreTex2 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skdumbledoreMesh Num=2 Texture=skdumbledoreTex2

//texture import (skdumbledoreTex3) -AdamJD 
#exec Texture Import File=Textures\skdumbledoreTex3.png Name=skdumbledoreTex3 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skdumbledoreMesh Num=3 Texture=skdumbledoreTex3

//anim notify imports -AdamJD
#exec Anim Notify Anim=skdumbledoreAnims Seq=Walk Time=0.99 Function=PlayFootStep
#exec Anim Notify Anim=skdumbledoreAnims Seq=Walk Time=0.5 Function=PlayFootStep

