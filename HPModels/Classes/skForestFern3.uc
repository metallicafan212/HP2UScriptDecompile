//================================================================================
// skForestFern3.
//================================================================================

class skForestFern3 extends HPMesh
  Abstract;
  
//model import (skForestFern3Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skForestFern3Mesh ModelFile=Models\skForestFern3Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skForestFern3Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skForestFern3Anims) -AdamJD 
#exec Anim Import Anim=skForestFern3Anims AnimFile=Models\skForestFern3Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skForestFern3Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skForestFern3Mesh Anim=skForestFern3Anims
#exec Anim Digest Anim=skForestFern3Anims VERBOSE 

//texture import (skForestFern3Tex0) -AdamJD 
#exec Texture Import File=Textures\skForestFern3Tex0.png Name=skForestFern3Tex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skForestFern3Mesh Num=0 Texture=skForestFern3Tex0

