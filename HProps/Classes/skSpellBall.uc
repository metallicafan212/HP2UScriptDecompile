//================================================================================
// skSpellBall.
//================================================================================

class skSpellBall extends HPMeshActor;

//model import (skSpellBallMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skSpellBallMesh ModelFile=Models\skSpellBallMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skSpellBallMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skSpellBallAnims) -AdamJD 
#exec Anim Import Anim=skSpellBallAnims AnimFile=Models\skSpellBallAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skSpellBallMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skSpellBallMesh Anim=skSpellBallAnims
#exec Anim Digest Anim=skSpellBallAnims VERBOSE 

//texture import (skSpellBallTex0) -AdamJD 
#exec Texture Import File=Textures\skSpellBallTex0.png Name=skSpellBallTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skSpellBallMesh Num=0 Texture=skSpellBallTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skSpellBallMesh
}
