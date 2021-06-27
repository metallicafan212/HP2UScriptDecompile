//================================================================================
// skbasilisk.
//================================================================================

class skbasilisk extends HPMesh
  Abstract;
  
//model import (skbasiliskMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skbasiliskMesh ModelFile=Models\skbasiliskMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skbasiliskMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skbasiliskAnims) -AdamJD 
#exec Anim Import Anim=skbasiliskAnims AnimFile=Models\skbasiliskAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skbasiliskMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skbasiliskMesh Anim=skbasiliskAnims
#exec Anim Digest Anim=skbasiliskAnims VERBOSE 

//texture import (skbasiliskTex0) -AdamJD 
#exec Texture Import File=Textures\skbasiliskTex0.png Name=skbasiliskTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skbasiliskMesh Num=0 Texture=skbasiliskTex0

//texture import (skbasiliskTex1) -AdamJD 
#exec Texture Import File=Textures\skbasiliskTex1.png Name=skbasiliskTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skbasiliskMesh Num=1 Texture=skbasiliskTex1

//texture import (skbasiliskTex2) -AdamJD 
#exec Texture Import File=Textures\skbasiliskTex2.png Name=skbasiliskTex2 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skbasiliskMesh Num=2 Texture=skbasiliskTex2

//texture import (skbasiliskTex3) -AdamJD 
#exec Texture Import File=Textures\skbasiliskTex3.png Name=skbasiliskTex3 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skbasiliskMesh Num=3 Texture=skbasiliskTex3

//anim notify imports -AdamJD
#exec Anim Notify Anim=skbasiliskAnims Seq=Idle Time=0.426 Function=PlayHissSound
#exec Anim Notify Anim=skbasiliskAnims Seq=Idle Time=0.787 Function=PlayHissSound
