//================================================================================
// skChickenLeg.
//================================================================================

class skChickenLeg extends HPMesh
  Abstract;
  
//model import (skChickenLegMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skChickenLegMesh ModelFile=Models\skChickenLegMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skChickenLegMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skChickenLegAnims) -AdamJD 
#exec Anim Import Anim=skChickenLegAnims AnimFile=Models\skChickenLegAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skChickenLegMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skChickenLegMesh Anim=skChickenLegAnims
#exec Anim Digest Anim=skChickenLegAnims VERBOSE 

//texture import (skChickenLegTex0) -AdamJD 
#exec Texture Import File=Textures\skChickenLegTex0.png Name=skChickenLegTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skChickenLegMesh Num=0 Texture=skChickenLegTex0

