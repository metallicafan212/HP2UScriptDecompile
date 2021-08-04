//================================================================================
// skForestFern4.
//================================================================================

class skForestFern4 extends HPMesh
  Abstract;
  
//model import (skForestFern4Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skForestFern4Mesh ModelFile=Models\skForestFern4Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skForestFern4Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skForestFern4Anims) -AdamJD 
#exec Anim Import Anim=skForestFern4Anims AnimFile=Models\skForestFern4Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skForestFern4Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skForestFern4Mesh Anim=skForestFern4Anims
#exec Anim Digest Anim=skForestFern4Anims VERBOSE 

//texture import (skForestFern4Tex0) -AdamJD 
#exec Texture Import File=Textures\skForestFern4Tex0.png Name=skForestFern4Tex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skForestFern4Mesh Num=0 Texture=skForestFern4Tex0

