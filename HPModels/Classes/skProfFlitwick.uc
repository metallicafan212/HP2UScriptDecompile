//================================================================================
// skProfFlitwick.
//================================================================================

class skProfFlitwick extends HPMesh
  Abstract;
  
//model import (skProfFlitwickMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skProfFlitwickMesh ModelFile=Models\skProfFlitwickMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skProfFlitwickMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skProfFlitwickAnims) -AdamJD 
#exec Anim Import Anim=skProfFlitwickAnims AnimFile=Models\skProfFlitwickAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skProfFlitwickMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skProfFlitwickMesh Anim=skProfFlitwickAnims
#exec Anim Digest Anim=skProfFlitwickAnims VERBOSE 

//texture import (skProfFlitwickTex0) -AdamJD 
#exec Texture Import File=Textures\skProfFlitwickTex0.png Name=skProfFlitwickTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skProfFlitwickMesh Num=0 Texture=skProfFlitwickTex0

//texture import (skProfFlitwickTex1) -AdamJD 
#exec Texture Import File=Textures\skProfFlitwickTex1.png Name=skProfFlitwickTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skProfFlitwickMesh Num=1 Texture=skProfFlitwickTex1

