//================================================================================
// skemptyplantpot.
//================================================================================

class skemptyplantpot extends HPMesh
  Abstract;
  
//model import (skemptyplantpotMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skemptyplantpotMesh ModelFile=Models\skemptyplantpotMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skemptyplantpotMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skemptyplantpotAnims) -AdamJD 
#exec Anim Import Anim=skemptyplantpotAnims AnimFile=Models\skemptyplantpotAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skemptyplantpotMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skemptyplantpotMesh Anim=skemptyplantpotAnims
#exec Anim Digest Anim=skemptyplantpotAnims VERBOSE 

//texture import (skemptyplantpotTex0) -AdamJD 
#exec Texture Import File=Textures\skemptyplantpotTex0.png Name=skemptyplantpotTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skemptyplantpotMesh Num=0 Texture=skemptyplantpotTex0

