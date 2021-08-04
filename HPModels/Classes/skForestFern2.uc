//================================================================================
// skForestFern2.
//================================================================================

class skForestFern2 extends HPMesh
  Abstract;
  
//model import (skForestFern2Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skForestFern2Mesh ModelFile=Models\skForestFern2Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skForestFern2Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skForestFern2Anims) -AdamJD 
#exec Anim Import Anim=skForestFern2Anims AnimFile=Models\skForestFern2Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skForestFern2Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skForestFern2Mesh Anim=skForestFern2Anims
#exec Anim Digest Anim=skForestFern2Anims VERBOSE 

//texture import (skForestFern2Tex0) -AdamJD 
#exec Texture Import File=Textures\skForestFern2Tex0.png Name=skForestFern2Tex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skForestFern2Mesh Num=0 Texture=skForestFern2Tex0

