//================================================================================
// skQuidGoal.
//================================================================================

class skQuidGoal extends HPMesh
  Abstract;
  
//model import (QuidGoalMesh) -AdamJD 
#exec Mesh ModelImport Mesh=QuidGoalMesh ModelFile=Models\QuidGoalMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=QuidGoalMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (QuidGoalAnims) -AdamJD 
#exec Anim Import Anim=QuidGoalAnims AnimFile=Models\QuidGoalAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=QuidGoalMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=QuidGoalMesh Anim=QuidGoalAnims
#exec Anim Digest Anim=QuidGoalAnims VERBOSE 

//texture import (QuidGoalTex0) -AdamJD 
#exec Texture Import File=Textures\QuidGoalTex0.png Name=QuidGoalTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=QuidGoalMesh Num=0 Texture=QuidGoalTex0

