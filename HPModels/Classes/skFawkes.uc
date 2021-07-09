//================================================================================
// skFawkes.
//================================================================================

class skFawkes extends HPMesh
  Abstract;
  
//model import (skFawkesMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skFawkesMesh ModelFile=Models\skFawkesMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skFawkesMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skFawkesAnims) -AdamJD 
#exec Anim Import Anim=skFawkesAnims AnimFile=Models\skFawkesAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skFawkesMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skFawkesMesh Anim=skFawkesAnims
#exec Anim Digest Anim=skFawkesAnims VERBOSE 

//texture import (skFawkesTex0) -AdamJD 
#exec Texture Import File=Textures\skFawkesTex0.png Name=skFawkesTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFawkesMesh Num=0 Texture=skFawkesTex0

//weapon import -AdamJD
#exec Mesh WeaponAttach Mesh=skFawkesMesh Bone="RightFoot"
#exec Mesh WeaponPosition Mesh=skFawkesMesh Yaw=128 Pitch=0 Roll=-118 X=0.0 Y=0.0 Z=0.0

//anim notify imports -AdamJD
#exec Anim Notify Anim=skFawkesAnims Seq=Fly Time=0.8 Function=PlayWingFlap
#exec Anim Notify Anim=skFawkesAnims Seq=hover Time=0.8 Function=PlayWingFlap
#exec Anim Notify Anim=skFawkesAnims Seq=AttackClaw Time=0.72 Function=PlayWingFlap

