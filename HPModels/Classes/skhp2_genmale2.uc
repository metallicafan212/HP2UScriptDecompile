//================================================================================
// skhp2_genmale2.
//================================================================================

class skhp2_genmale2 extends HPMesh
  Abstract;
  
//model import (skhp2_genmale2Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skhp2_genmale2Mesh ModelFile=Models\skhp2_genmale2Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skhp2_genmale2Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//shared anim import (skGenMaleAnims) -AdamJD 
#exec MeshMap Scale MeshMap=skhp2_genmale2Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skhp2_genmale2Mesh Anim=skGenMaleAnims

//KW didn't add any textures for skhp2_genmale2 -AdamJD

//weapon import -AdamJD
#exec Mesh WeaponAttach Mesh=skhp2_genmale2Mesh Bone="RightHand"
#exec Mesh WeaponPosition Mesh=skhp2_genmale2Mesh Yaw=0 Pitch=0 Roll=10 X=0.0 Y=0.0 Z=0.0 
