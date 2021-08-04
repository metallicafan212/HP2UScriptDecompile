//================================================================================
// skhp2_genfemale2.
//================================================================================

class skhp2_genfemale2 extends HPMesh
  Abstract;
  
//model import (skhp2_genfemale2Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skhp2_genfemale2Mesh ModelFile=Models\skhp2_genfemale2Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skhp2_genfemale2Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//shared anim import (skGenFemaleAnims) -AdamJD 
#exec MeshMap Scale MeshMap=skhp2_genfemale2Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skhp2_genfemale2Mesh Anim=skGenFemaleAnims

//KW didn't add any textures for skhp2_genfemale2 -AdamJD

//weapon import -AdamJD
#exec Mesh WeaponAttach Mesh=skhp2_genfemale2Mesh Bone="RightHand"
#exec Mesh WeaponPosition Mesh=skhp2_genfemale2Mesh Yaw=0 Pitch=0 Roll=10 X=0.0 Y=0.0 Z=0.0 

