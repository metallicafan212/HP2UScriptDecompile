//================================================================================
// skWhompingWIllow.
//================================================================================

class skWhompingWIllow extends HPMesh
  Abstract;
  
//model import (skWhompingWIllowMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skWhompingWIllowMesh ModelFile=Models\skWhompingWIllowMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skWhompingWIllowMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skWhompingWIllowAnims) -AdamJD 
#exec Anim Import Anim=skWhompingWIllowAnims AnimFile=Models\skWhompingWIllowAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skWhompingWIllowMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skWhompingWIllowMesh Anim=skWhompingWIllowAnims
#exec Anim Digest Anim=skWhompingWIllowAnims VERBOSE 

//texture import (skWhompingWIllowTex0) -AdamJD 
#exec Texture Import File=Textures\skWhompingWIllowTex0.png Name=skWhompingWIllowTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skWhompingWIllowMesh Num=0 Texture=skWhompingWIllowTex0

//texture import (skWhompingWIllowTex1) -AdamJD 
#exec Texture Import File=Textures\skWhompingWIllowTex1.png Name=skWhompingWIllowTex1 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skWhompingWIllowMesh Num=1 Texture=skWhompingWIllowTex1

//texture import (skWhompingWIllowTex2) -AdamJD 
#exec Texture Import File=Textures\skWhompingWIllowTex2.png Name=skWhompingWIllowTex2 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skWhompingWIllowMesh Num=2 Texture=skWhompingWIllowTex2

//texture import (skWhompingWIllowTex3) -AdamJD 
#exec Texture Import File=Textures\skWhompingWIllowTex3.png Name=skWhompingWIllowTex3 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skWhompingWIllowMesh Num=3 Texture=skWhompingWIllowTex3

//texture import (skWhompingWIllowTex4) -AdamJD 
#exec Texture Import File=Textures\skWhompingWIllowTex4.png Name=skWhompingWIllowTex4 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skWhompingWIllowMesh Num=4 Texture=skWhompingWIllowTex4

