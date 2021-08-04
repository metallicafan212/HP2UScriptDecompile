//================================================================================
// skSnitch.
//================================================================================

class skSnitch extends HPMesh
  Abstract;
  
//model import (skSnitchMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skSnitchMesh ModelFile=Models\skSnitchMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skSnitchMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skSnitchAnims) -AdamJD 
#exec Anim Import Anim=skSnitchAnims AnimFile=Models\skSnitchAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skSnitchMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skSnitchMesh Anim=skSnitchAnims
#exec Anim Digest Anim=skSnitchAnims VERBOSE 

//texture import (skSnitchTex0) -AdamJD 
#exec Texture Import File=Textures\skSnitchTex0.png Name=skSnitchTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skSnitchMesh Num=0 Texture=skSnitchTex0

