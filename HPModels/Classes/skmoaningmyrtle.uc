//================================================================================
// skmoaningmyrtle.
//================================================================================

class skmoaningmyrtle extends HPMesh
  Abstract;
  
//model import (skmoaningmyrtleMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skmoaningmyrtleMesh ModelFile=Models\skmoaningmyrtleMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skmoaningmyrtleMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skmoaningmyrtleAnims) -AdamJD 
#exec Anim Import Anim=skmoaningmyrtleAnims AnimFile=Models\skmoaningmyrtleAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skmoaningmyrtleMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skmoaningmyrtleMesh Anim=skmoaningmyrtleAnims
#exec Anim Digest Anim=skmoaningmyrtleAnims VERBOSE 

//texture import (skmoaningmyrtleTex0) -AdamJD 
#exec Texture Import File=Textures\skmoaningmyrtleTex0.png Name=skmoaningmyrtleTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skmoaningmyrtleMesh Num=0 Texture=skmoaningmyrtleTex0

//texture import (skmoaningmyrtleTex1) -AdamJD 
#exec Texture Import File=Textures\skmoaningmyrtleTex1.png Name=skmoaningmyrtleTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skmoaningmyrtleMesh Num=1 Texture=skmoaningmyrtleTex1

//texture import (skmoaningmyrtleTex2) -AdamJD 
#exec Texture Import File=Textures\skmoaningmyrtleTex2.png Name=skmoaningmyrtleTex2 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skmoaningmyrtleMesh Num=2 Texture=skmoaningmyrtleTex2

//texture import (skmoaningmyrtleTex3) -AdamJD 
#exec Texture Import File=Textures\skmoaningmyrtleTex3.png Name=skmoaningmyrtleTex3 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skmoaningmyrtleMesh Num=3 Texture=skmoaningmyrtleTex3

