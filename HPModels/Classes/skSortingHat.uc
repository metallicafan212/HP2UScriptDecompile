//================================================================================
// skSortingHat.
//================================================================================

class skSortingHat extends HPMesh
  Abstract;
  
//model import (skSortingHatMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skSortingHatMesh ModelFile=Models\skSortingHatMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skSortingHatMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skSortingHatAnims) -AdamJD 
#exec Anim Import Anim=skSortingHatAnims AnimFile=Models\skSortingHatAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skSortingHatMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skSortingHatMesh Anim=skSortingHatAnims
#exec Anim Digest Anim=skSortingHatAnims VERBOSE 

//texture import (skSortingHatTex0) -AdamJD 
#exec Texture Import File=Textures\skSortingHatTex0.png Name=skSortingHatTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skSortingHatMesh Num=0 Texture=skSortingHatTex0

