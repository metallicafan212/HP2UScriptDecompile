//================================================================================
// skCrabbe.
//================================================================================

class skCrabbe extends HPMesh
  Abstract;
  
//model import (skCrabbeMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skCrabbeMesh ModelFile=Models\skCrabbeMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skCrabbeMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0

//shared anim import (skGenMaleAnims) -AdamJD 
#exec MeshMap Scale MeshMap=skCrabbeMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skCrabbeMesh Anim=skGenMaleAnims

//texture import (skCrabbeTex0) -AdamJD 
#exec Texture Import File=Textures\skCrabbeTex0.png Name=skCrabbeTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skCrabbeMesh Num=0 Texture=skCrabbeTex0

//texture import (skCrabbeTex1) -AdamJD 
#exec Texture Import File=Textures\skCrabbeTex1.png Name=skCrabbeTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skCrabbeMesh Num=1 Texture=skCrabbeTex1

