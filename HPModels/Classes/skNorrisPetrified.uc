//================================================================================
// skNorrisPetrified.
//================================================================================

class skNorrisPetrified extends HPMesh
  Abstract;
  
//model import (skNorrisPetrifiedMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skNorrisPetrifiedMesh ModelFile=Models\skNorrisPetrifiedMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skNorrisPetrifiedMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skNorrisPetrifiedAnims) -AdamJD 
#exec Anim Import Anim=skNorrisPetrifiedAnims AnimFile=Models\skNorrisPetrifiedAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skNorrisPetrifiedMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skNorrisPetrifiedMesh Anim=skNorrisPetrifiedAnims
#exec Anim Digest Anim=skNorrisPetrifiedAnims VERBOSE 

//texture import (skNorrisPetrifiedTex0) -AdamJD 
#exec Texture Import File=Textures\skNorrisPetrifiedTex0.png Name=skNorrisPetrifiedTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skNorrisPetrifiedMesh Num=0 Texture=skNorrisPetrifiedTex0

//texture import (skNorrisPetrifiedTex1) -AdamJD 
#exec Texture Import File=Textures\skNorrisPetrifiedTex1.png Name=skNorrisPetrifiedTex1 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 MaskedOverride=(R=0,G=0,B=0,A=255) Group=Skins
#exec MeshMap SetTexture MeshMap=skNorrisPetrifiedMesh Num=1 Texture=skNorrisPetrifiedTex1

