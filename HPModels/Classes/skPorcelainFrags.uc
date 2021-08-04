//================================================================================
// skPorcelainFrags.
//================================================================================

class skPorcelainFrags extends HPMesh
  Abstract;
  
//model import (skPorcelainFragsMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skPorcelainFragsMesh ModelFile=Models\skPorcelainFragsMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skPorcelainFragsMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skPorcelainFragsAnims) -AdamJD 
#exec Anim Import Anim=skPorcelainFragsAnims AnimFile=Models\skPorcelainFragsAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skPorcelainFragsMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skPorcelainFragsMesh Anim=skPorcelainFragsAnims
#exec Anim Digest Anim=skPorcelainFragsAnims VERBOSE 

//texture import (skPorcelainFragsTex0) -AdamJD 
#exec Texture Import File=Textures\skPorcelainFragsTex0.png Name=skPorcelainFragsTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skPorcelainFragsMesh Num=0 Texture=skPorcelainFragsTex0

