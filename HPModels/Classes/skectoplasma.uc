//================================================================================
// skectoplasma.
//================================================================================

class skectoplasma extends HPMesh
  Abstract;
  
//model import (skectoplasmaMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skectoplasmaMesh ModelFile=Models\skectoplasmaMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skectoplasmaMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skectoplasmaAnims) -AdamJD 
#exec Anim Import Anim=skectoplasmaAnims AnimFile=Models\skectoplasmaAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skectoplasmaMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skectoplasmaMesh Anim=skectoplasmaAnims
#exec Anim Digest Anim=skectoplasmaAnims VERBOSE 

//texture import (skectoplasmaTex0) -AdamJD 
#exec Texture Import File=Textures\skectoplasmaTex0.png Name=skectoplasmaTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skectoplasmaMesh Num=0 Texture=skectoplasmaTex0

