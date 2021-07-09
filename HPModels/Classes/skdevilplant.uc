//================================================================================
// skdevilplant.
//================================================================================

class skdevilplant extends HPMesh
  Abstract;
  
//model import (skdevilplantMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skdevilplantMesh ModelFile=Models\skdevilplantMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skdevilplantMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skdevilplantAnims) -AdamJD 
#exec Anim Import Anim=skdevilplantAnims AnimFile=Models\skdevilplantAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skdevilplantMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skdevilplantMesh Anim=skdevilplantAnims
#exec Anim Digest Anim=skdevilplantAnims VERBOSE 

//texture import (skdevilplantTex0) -AdamJD 
#exec Texture Import File=Textures\skdevilplantTex0.png Name=skdevilplantTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skdevilplantMesh Num=0 Texture=skdevilplantTex0

//texture import (skdevilplantTex1) -AdamJD 
#exec Texture Import File=Textures\skdevilplantTex1.png Name=skdevilplantTex1 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skdevilplantMesh Num=1 Texture=skdevilplantTex1

