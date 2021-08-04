//================================================================================
// skironchest.
//================================================================================

class skironchest extends HPMesh
  Abstract;
  
//model import (skironchestMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skironchestMesh ModelFile=Models\skironchestMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skironchestMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//shared anim import (skbronzechestAnims) -AdamJD 
#exec MeshMap Scale MeshMap=skironchestMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skironchestMesh Anim=skbronzechestAnims

//texture import (skironchestTex0) -AdamJD 
#exec Texture Import File=Textures\skironchestTex0.png Name=skironchestTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skironchestMesh Num=0 Texture=skironchestTex0

