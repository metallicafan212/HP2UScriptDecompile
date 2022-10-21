//================================================================================
// skPlantsCactus1.
//================================================================================

class skPlantsCactus1 extends HPMeshActor;

//model import (skPlantsCactus1Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skPlantsCactus1Mesh ModelFile=Models\skPlantsCactus1Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skPlantsCactus1Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skPlantsCactus1Anims) -AdamJD 
#exec Anim Import Anim=skPlantsCactus1Anims AnimFile=Models\skPlantsCactus1Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skPlantsCactus1Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skPlantsCactus1Mesh Anim=skPlantsCactus1Anims
#exec Anim Digest Anim=skPlantsCactus1Anims VERBOSE 

//texture import (skPlantsCactus1Tex0) -AdamJD 
#exec Texture Import File=Textures\skPlantsCactus1Tex0.png Name=skPlantsCactus1Tex0 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 MaskedOverride=(R=255,G=0,B=255,A=255) Group=Skins 
#exec MeshMap SetTexture MeshMap=skPlantsCactus1Mesh Num=0 Texture=skPlantsCactus1Tex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skPlantsCactus1Mesh
}
