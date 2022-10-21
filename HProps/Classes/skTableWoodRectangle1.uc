//================================================================================
// skTableWoodRectangle1.
//================================================================================

class skTableWoodRectangle1 extends HPMeshActor;

//model import (skTableWoodRectangle1Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skTableWoodRectangle1Mesh ModelFile=Models\skTableWoodRectangle1Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skTableWoodRectangle1Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skTableWoodRectangle1Anims) -AdamJD 
#exec Anim Import Anim=skTableWoodRectangle1Anims AnimFile=Models\skTableWoodRectangle1Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skTableWoodRectangle1Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skTableWoodRectangle1Mesh Anim=skTableWoodRectangle1Anims
#exec Anim Digest Anim=skTableWoodRectangle1Anims VERBOSE 

//texture import (skTableWoodRectangle1Tex0) -AdamJD 
#exec Texture Import File=Textures\skTableWoodRectangle1Tex0.png Name=skTableWoodRectangle1Tex0 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 MaskedOverride=(R=255,G=0,B=255,A=255) Group=Skins 
#exec MeshMap SetTexture MeshMap=skTableWoodRectangle1Mesh Num=0 Texture=skTableWoodRectangle1Tex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skTableWoodRectangle1Mesh
}
