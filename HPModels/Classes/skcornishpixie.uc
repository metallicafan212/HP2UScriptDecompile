//================================================================================
// skcornishpixie.
//================================================================================

class skcornishpixie extends HPMesh
  Abstract;
  
//model import (skcornishpixieMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skcornishpixieMesh ModelFile=Models\skcornishpixieMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skcornishpixieMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skcornishpixieAnims) -AdamJD 
#exec Anim Import Anim=skcornishpixieAnims AnimFile=Models\skcornishpixieAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skcornishpixieMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skcornishpixieMesh Anim=skcornishpixieAnims
#exec Anim Digest Anim=skcornishpixieAnims VERBOSE 

//texture import (skcornishpixieTex0) -AdamJD 
#exec Texture Import File=Textures\skcornishpixieTex0.png Name=skcornishpixieTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skcornishpixieMesh Num=0 Texture=skcornishpixieTex0

//texture import (skcornishpixieTex1) -AdamJD 
#exec Texture Import File=Textures\skcornishpixieTex1.png Name=skcornishpixieTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skcornishpixieMesh Num=1 Texture=skcornishpixieTex1

