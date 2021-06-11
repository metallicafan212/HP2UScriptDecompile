//================================================================================
// skwallsconceCh.
//================================================================================

class skwallsconceCh extends HPMeshActor;

//model import (skwallsconceChMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skwallsconceChMesh ModelFile=Models\skwallsconceChMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skwallsconceChMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skwallsconceChAnims) -AdamJD 
#exec Anim Import Anim=skwallsconceChAnims AnimFile=Models\skwallsconceChAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skwallsconceChMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skwallsconceChMesh Anim=skwallsconceChAnims
#exec Anim Digest Anim=skwallsconceChAnims VERBOSE 

//texture import (skwallsconceChTex0) -AdamJD 
#exec Texture Import File=Textures\skwallsconceChTex0.png Name=skwallsconceChTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skwallsconceChMesh Num=0 Texture=skwallsconceChTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skwallsconceChMesh
}
