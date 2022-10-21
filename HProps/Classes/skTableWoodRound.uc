//================================================================================
// skTableWoodRound.
//================================================================================

class skTableWoodRound extends HPMeshActor;

//model import (skTableWoodRoundMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skTableWoodRoundMesh ModelFile=Models\skTableWoodRoundMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skTableWoodRoundMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skTableWoodRoundAnims) -AdamJD 
#exec Anim Import Anim=skTableWoodRoundAnims AnimFile=Models\skTableWoodRoundAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skTableWoodRoundMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skTableWoodRoundMesh Anim=skTableWoodRoundAnims
#exec Anim Digest Anim=skTableWoodRoundAnims VERBOSE 

//texture import (skTableWoodRoundTex0) -AdamJD 
#exec Texture Import File=Textures\skTableWoodRoundTex0.png Name=skTableWoodRoundTex0 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 MaskedOverride=(R=255,G=0,B=255,A=255) Group=Skins 
#exec MeshMap SetTexture MeshMap=skTableWoodRoundMesh Num=0 Texture=skTableWoodRoundTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skTableWoodRoundMesh
}
