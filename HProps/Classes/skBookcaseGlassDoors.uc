//================================================================================
// skBookcaseGlassDoors.
//================================================================================

class skBookcaseGlassDoors extends HPMeshActor;

//model import (skBookcaseGlassDoorsMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBookcaseGlassDoorsMesh ModelFile=Models\skBookcaseGlassDoorsMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBookcaseGlassDoorsMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBookcaseGlassDoorsAnims) -AdamJD 
#exec Anim Import Anim=skBookcaseGlassDoorsAnims AnimFile=Models\skBookcaseGlassDoorsAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBookcaseGlassDoorsMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBookcaseGlassDoorsMesh Anim=skBookcaseGlassDoorsAnims
#exec Anim Digest Anim=skBookcaseGlassDoorsAnims VERBOSE 

//texture import (skBookcaseGlassDoorsTex0) -AdamJD 
#exec Texture Import File=Textures\skBookcaseGlassDoorsTex0.png Name=skBookcaseGlassDoorsTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBookcaseGlassDoorsMesh Num=0 Texture=skBookcaseGlassDoorsTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBookcaseGlassDoorsMesh
}
