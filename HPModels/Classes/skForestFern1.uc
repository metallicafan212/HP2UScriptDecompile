//================================================================================
// skForestFern1.
//================================================================================

class skForestFern1 extends HPMesh
  Abstract;
  
//model import (skForestFern1Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skForestFern1Mesh ModelFile=Models\skForestFern1Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skForestFern1Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skForestFern1Anims) -AdamJD 
#exec Anim Import Anim=skForestFern1Anims AnimFile=Models\skForestFern1Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skForestFern1Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skForestFern1Mesh Anim=skForestFern1Anims
#exec Anim Digest Anim=skForestFern1Anims VERBOSE 

//texture import (skForestFern1Tex0) -AdamJD 
#exec Texture Import File=Textures\skForestFern1Tex0.png Name=skForestFern1Tex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skForestFern1Mesh Num=0 Texture=skForestFern1Tex0

