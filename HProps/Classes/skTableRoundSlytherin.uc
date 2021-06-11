//================================================================================
// skTableRoundSlytherin.
//================================================================================

class skTableRoundSlytherin extends HPMeshActor;

//model import (skTableRoundSlytherinMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skTableRoundSlytherinMesh ModelFile=Models\skTableRoundSlytherinMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skTableRoundSlytherinMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skTableRoundSlytherinAnims) -AdamJD 
#exec Anim Import Anim=skTableRoundSlytherinAnims AnimFile=Models\skTableRoundSlytherinAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skTableRoundSlytherinMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skTableRoundSlytherinMesh Anim=skTableRoundSlytherinAnims
#exec Anim Digest Anim=skTableRoundSlytherinAnims VERBOSE 

//texture import (skTableRoundSlytherinTex0) -AdamJD 
#exec Texture Import File=Textures\skTableRoundSlytherinTex0.png Name=skTableRoundSlytherinTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skTableRoundSlytherinMesh Num=0 Texture=skTableRoundSlytherinTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skTableRoundSlytherinMesh
}
