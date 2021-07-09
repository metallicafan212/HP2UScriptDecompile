//================================================================================
// skHermioneInfimary.
//================================================================================

class skHermioneInfimary extends HPMesh
  Abstract;
  
//model import (skHermioneInfimaryMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skHermioneInfimaryMesh ModelFile=Models\skHermioneInfimaryMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skHermioneInfimaryMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skHermioneInfimaryAnims) -AdamJD 
#exec Anim Import Anim=skHermioneInfimaryAnims AnimFile=Models\skHermioneInfimaryAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skHermioneInfimaryMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skHermioneInfimaryMesh Anim=skHermioneInfimaryAnims
#exec Anim Digest Anim=skHermioneInfimaryAnims VERBOSE 

//texture import (skHermioneInfimaryTex0) -AdamJD 
#exec Texture Import File=Textures\skHermioneInfimaryTex0.png Name=skHermioneInfimaryTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHermioneInfimaryMesh Num=0 Texture=skHermioneInfimaryTex0

//texture import (skHermioneInfimaryTex1) -AdamJD 
#exec Texture Import File=Textures\skHermioneInfimaryTex1.png Name=skHermioneInfimaryTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHermioneInfimaryMesh Num=1 Texture=skHermioneInfimaryTex1

//texture import (skHermioneInfimaryTex2) -AdamJD 
#exec Texture Import File=Textures\skHermioneInfimaryTex2.png Name=skHermioneInfimaryTex2 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHermioneInfimaryMesh Num=2 Texture=skHermioneInfimaryTex2

//texture import (skHermioneInfimaryTex3) -AdamJD 
#exec Texture Import File=Textures\skHermioneInfimaryTex3.png Name=skHermioneInfimaryTex3 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHermioneInfimaryMesh Num=3 Texture=skHermioneInfimaryTex3

//texture import (skHermioneInfimaryTex4) -AdamJD 
#exec Texture Import File=Textures\skHermioneInfimaryTex4.png Name=skHermioneInfimaryTex4 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHermioneInfimaryMesh Num=4 Texture=skHermioneInfimaryTex4

