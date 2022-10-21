//================================================================================
// skBathroomSink.
//================================================================================

class skBathroomSink extends HPMeshActor;

//model import (skBathroomSinkMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBathroomSinkMesh ModelFile=Models\skBathroomSinkMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBathroomSinkMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBathroomSinkAnims) -AdamJD 
#exec Anim Import Anim=skBathroomSinkAnims AnimFile=Models\skBathroomSinkAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBathroomSinkMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBathroomSinkMesh Anim=skBathroomSinkAnims
#exec Anim Digest Anim=skBathroomSinkAnims VERBOSE 

//texture import (skBathroomSinkTex0) -AdamJD 
#exec Texture Import File=Textures\skBathroomSinkTex0.png Name=skBathroomSinkTex0 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 MaskedOverride=(R=255,G=0,B=255,A=255) Group=Skins 
#exec MeshMap SetTexture MeshMap=skBathroomSinkMesh Num=0 Texture=skBathroomSinkTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBathroomSinkMesh
}
