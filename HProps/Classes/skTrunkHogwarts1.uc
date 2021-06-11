//================================================================================
// skTrunkHogwarts1.
//================================================================================

class skTrunkHogwarts1 extends HPMeshActor;

//model import (skTrunkHogwarts1Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skTrunkHogwarts1Mesh ModelFile=Models\skTrunkHogwarts1Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skTrunkHogwarts1Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skTrunkHogwarts1Anims) -AdamJD 
#exec Anim Import Anim=skTrunkHogwarts1Anims AnimFile=Models\skTrunkHogwarts1Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skTrunkHogwarts1Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skTrunkHogwarts1Mesh Anim=skTrunkHogwarts1Anims
#exec Anim Digest Anim=skTrunkHogwarts1Anims VERBOSE 

//texture import (skTrunkHogwarts1Tex0) -AdamJD 
#exec Texture Import File=Textures\skTrunkHogwarts1Tex0.png Name=skTrunkHogwarts1Tex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skTrunkHogwarts1Mesh Num=0 Texture=skTrunkHogwarts1Tex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skTrunkHogwarts1Mesh
}
