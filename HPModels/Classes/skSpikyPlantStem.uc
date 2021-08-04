//================================================================================
// skSpikyPlantStem.
//================================================================================

class skSpikyPlantStem extends HPMesh
  Abstract;
  
//model import (skSpikyPlantStemMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skSpikyPlantStemMesh ModelFile=Models\skSpikyPlantStemMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skSpikyPlantStemMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skSpikyPlantStemAnims) -AdamJD 
#exec Anim Import Anim=skSpikyPlantStemAnims AnimFile=Models\skSpikyPlantStemAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skSpikyPlantStemMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skSpikyPlantStemMesh Anim=skSpikyPlantStemAnims
#exec Anim Digest Anim=skSpikyPlantStemAnims VERBOSE 

//texture import (skSpikyPlantStemTex0) -AdamJD 
#exec Texture Import File=Textures\skSpikyPlantStemTex0.png Name=skSpikyPlantStemTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skSpikyPlantStemMesh Num=0 Texture=skSpikyPlantStemTex0

