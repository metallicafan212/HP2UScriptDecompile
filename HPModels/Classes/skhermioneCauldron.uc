//================================================================================
// skhermioneCauldron.
//================================================================================

class skhermioneCauldron extends HPMesh
  Abstract;
  
//model import (skhermioneCauldronMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skhermioneCauldronMesh ModelFile=Models\skhermioneCauldronMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skhermioneCauldronMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skhermioneCauldronAnims) -AdamJD 
#exec Anim Import Anim=skhermioneCauldronAnims AnimFile=Models\skhermioneCauldronAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skhermioneCauldronMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skhermioneCauldronMesh Anim=skhermioneCauldronAnims
#exec Anim Digest Anim=skhermioneCauldronAnims VERBOSE 

//texture import (skhermioneCauldronTex0) -AdamJD 
#exec Texture Import File=Textures\skhermioneCauldronTex0.png Name=skhermioneCauldronTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skhermioneCauldronMesh Num=0 Texture=skhermioneCauldronTex0

//texture import (skhermioneCauldronTex1) -AdamJD 
#exec Texture Import File=Textures\skhermioneCauldronTex1.png Name=skhermioneCauldronTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skhermioneCauldronMesh Num=1 Texture=skhermioneCauldronTex1

//texture import (skhermioneCauldronTex2) -AdamJD 
#exec Texture Import File=Textures\skhermioneCauldronTex2.png Name=skhermioneCauldronTex2 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skhermioneCauldronMesh Num=2 Texture=skhermioneCauldronTex2

//texture import (skhermioneCauldronTex3) -AdamJD 
#exec Texture Import File=Textures\skhermioneCauldronTex3.png Name=skhermioneCauldronTex3 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skhermioneCauldronMesh Num=3 Texture=skhermioneCauldronTex3

//texture import (skhermioneCauldronTex4) -AdamJD 
#exec Texture Import File=Textures\skhermioneCauldronTex4.png Name=skhermioneCauldronTex4 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skhermioneCauldronMesh Num=4 Texture=skhermioneCauldronTex4

//texture import (skhermioneCauldronTex5) -AdamJD 
#exec Texture Import File=Textures\skhermioneCauldronTex5.png Name=skhermioneCauldronTex5 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skhermioneCauldronMesh Num=5 Texture=skhermioneCauldronTex5

