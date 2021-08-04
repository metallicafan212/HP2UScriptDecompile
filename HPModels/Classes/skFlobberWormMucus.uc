//================================================================================
// skFlobberWormMucus.
//================================================================================

class skFlobberWormMucus extends HPMesh
  Abstract;
  
//model import (skFlobberWormMucusMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skFlobberWormMucusMesh ModelFile=Models\skFlobberWormMucusMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skFlobberWormMucusMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//shared anim import (skectoblobAnims) -AdamJD 
#exec MeshMap Scale MeshMap=skFlobberWormMucusMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skFlobberWormMucusMesh Anim=skectoblobAnims

//texture import (skFlobberWormMucusTex0) -AdamJD 
#exec Texture Import File=Textures\skFlobberWormMucusTex0.png Name=skFlobberWormMucusTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFlobberWormMucusMesh Num=0 Texture=skFlobberWormMucusTex0

