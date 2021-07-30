//================================================================================
// skSpikyPlant.
//================================================================================

class skSpikyPlant extends HPMesh
  Abstract;
  
//model import (skSpikyPlantMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skSpikyPlantMesh ModelFile=Models\skSpikyPlantMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skSpikyPlantMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skSpikyPlantAnims) -AdamJD 
#exec Anim Import Anim=skSpikyPlantAnims AnimFile=Models\skSpikyPlantAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skSpikyPlantMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skSpikyPlantMesh Anim=skSpikyPlantAnims
#exec Anim Digest Anim=skSpikyPlantAnims VERBOSE 

//texture import (skSpikyPlantTex0) -AdamJD 
#exec Texture Import File=Textures\skSpikyPlantTex0.png Name=skSpikyPlantTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skSpikyPlantMesh Num=0 Texture=skSpikyPlantTex0

