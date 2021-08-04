//================================================================================
// skMadamePomfrey.
//================================================================================

class skMadamePomfrey extends HPMesh
  Abstract;
  
//model import (skmadamepomfreyMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skmadamepomfreyMesh ModelFile=Models\skmadamepomfreyMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skmadamepomfreyMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skmadamepomfreyAnims) -AdamJD 
#exec Anim Import Anim=skmadamepomfreyAnims AnimFile=Models\skmadamepomfreyAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skmadamepomfreyMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skmadamepomfreyMesh Anim=skmadamepomfreyAnims
#exec Anim Digest Anim=skmadamepomfreyAnims VERBOSE 

//texture import (skmadamepomfreyTex0) -AdamJD 
#exec Texture Import File=Textures\skmadamepomfreyTex0.png Name=skmadamepomfreyTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skmadamepomfreyMesh Num=0 Texture=skmadamepomfreyTex0

//texture import (skmadamepomfreyTex1) -AdamJD 
#exec Texture Import File=Textures\skmadamepomfreyTex1.png Name=skmadamepomfreyTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skmadamepomfreyMesh Num=1 Texture=skmadamepomfreyTex1

