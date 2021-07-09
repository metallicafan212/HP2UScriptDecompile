//================================================================================
// skectoblob.
//================================================================================

class skectoblob extends HPMesh
  Abstract;
  
//model import (skectoblobMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skectoblobMesh ModelFile=Models\skectoblobMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skectoblobMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//shared anim import (skectoblobAnims) -AdamJD 
#exec MeshMap Scale MeshMap=skectoblobMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skectoblobMesh Anim=skectoblobAnims

//texture import (skectoblobTex0) -AdamJD 
#exec Texture Import File=Textures\skectoblobTex0.png Name=skectoblobTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skectoblobMesh Num=0 Texture=skectoblobTex0

