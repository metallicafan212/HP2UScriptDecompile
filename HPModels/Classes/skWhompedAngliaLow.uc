//================================================================================
// skWhompedAngliaLow.
//================================================================================

class skWhompedAngliaLow extends HPMesh
  Abstract;
  
//model import (skWhompedAngliaLowMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skWhompedAngliaLowMesh ModelFile=Models\skWhompedAngliaLowMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skWhompedAngliaLowMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skWhompedAngliaLowAnims) -AdamJD 
#exec Anim Import Anim=skWhompedAngliaLowAnims AnimFile=Models\skWhompedAngliaLowAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skWhompedAngliaLowMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skWhompedAngliaLowMesh Anim=skWhompedAngliaLowAnims
#exec Anim Digest Anim=skWhompedAngliaLowAnims VERBOSE 

//texture import (skWhompedAngliaLowTex0) -AdamJD 
#exec Texture Import File=Textures\skWhompedAngliaLowTex0.png Name=skWhompedAngliaLowTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skWhompedAngliaLowMesh Num=0 Texture=skWhompedAngliaLowTex0

//texture import (skWhompedAngliaLowTex1) -AdamJD 
#exec Texture Import File=Textures\skWhompedAngliaLowTex1.png Name=skWhompedAngliaLowTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skWhompedAngliaLowMesh Num=1 Texture=skWhompedAngliaLowTex1

