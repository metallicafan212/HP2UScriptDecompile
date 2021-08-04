//================================================================================
// skTomRiddleSepia.
//================================================================================

class skTomRiddleSepia extends HPMesh
  Abstract;
  
//model import (skTomRiddleSepiaMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skTomRiddleSepiaMesh ModelFile=Models\skTomRiddleSepiaMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skTomRiddleSepiaMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//shared anim import (skTomRiddleAnims) -AdamJD 
#exec MeshMap Scale MeshMap=skTomRiddleSepiaMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skTomRiddleSepiaMesh Anim=skTomRiddleAnims

//texture import (skTomRiddleSepiaTex0) -AdamJD 
#exec Texture Import File=Textures\skTomRiddleSepiaTex0.png Name=skTomRiddleSepiaTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skTomRiddleSepiaMesh Num=0 Texture=skTomRiddleSepiaTex0

//texture import (skTomRiddleSepiaTex1) -AdamJD 
#exec Texture Import File=Textures\skTomRiddleSepiaTex1.png Name=skTomRiddleSepiaTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skTomRiddleSepiaMesh Num=1 Texture=skTomRiddleSepiaTex1

