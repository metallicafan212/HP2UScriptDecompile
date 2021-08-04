//================================================================================
// skwoodchest.
//================================================================================

class skwoodchest extends HPMesh
  Abstract;
  
//model import (skwoodchestMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skwoodchestMesh ModelFile=Models\skwoodchestMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skwoodchestMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//shared anim import (skbronzechestAnims) -AdamJD 
#exec MeshMap Scale MeshMap=skwoodchestMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skwoodchestMesh Anim=skbronzechestAnims

//texture import (skwoodchestTex0) -AdamJD 
#exec Texture Import File=Textures\skwoodchestTex0.png Name=skwoodchestTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skwoodchestMesh Num=0 Texture=skwoodchestTex0

