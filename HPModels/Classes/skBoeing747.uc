//================================================================================
// skBoeing747.
//================================================================================

class skBoeing747 extends HPMesh
  Abstract;
  
//model import (skBoeing747Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBoeing747Mesh ModelFile=Models\skBoeing747Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBoeing747Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBoeing747Anims) -AdamJD 
#exec Anim Import Anim=skBoeing747Anims AnimFile=Models\skBoeing747Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBoeing747Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBoeing747Mesh Anim=skBoeing747Anims
#exec Anim Digest Anim=skBoeing747Anims VERBOSE 

//texture import (skBoeing747Tex0) -AdamJD 
#exec Texture Import File=Textures\skBoeing747Tex0.png Name=skBoeing747Tex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBoeing747Mesh Num=0 Texture=skBoeing747Tex0

//texture import (skBoeing747Tex1) -AdamJD 
#exec Texture Import File=Textures\skBoeing747Tex1.png Name=skBoeing747Tex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBoeing747Mesh Num=1 Texture=skBoeing747Tex1

//texture import (skBoeing747Tex2) -AdamJD 
#exec Texture Import File=Textures\skBoeing747Tex2.png Name=skBoeing747Tex2 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBoeing747Mesh Num=2 Texture=skBoeing747Tex2

