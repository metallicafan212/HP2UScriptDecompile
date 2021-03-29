//================================================================================
// skBlackboard1.
//================================================================================

class skBlackboard1 extends HPMeshActor;

//model import (skBlackboard1Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBlackboard1Mesh ModelFile=Models\skBlackboard1Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBlackboard1Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBlackboard1Anims) -AdamJD 
#exec Anim Import Anim=skBlackboard1Anims AnimFile=Models\skBlackboard1Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBlackboard1Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBlackboard1Mesh Anim=skBlackboard1Anims
#exec Anim Digest Anim=skBlackboard1Anims VERBOSE 

//texture import (skBlackboard1Tex0) -AdamJD 
#exec Texture Import File=Textures\skBlackboard1Tex0.png Name=skBlackboard1Tex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBlackboard1Mesh Num=0 Texture=skBlackboard1Tex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBlackboard1Mesh
}
