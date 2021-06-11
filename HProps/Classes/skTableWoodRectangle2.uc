//================================================================================
// skTableWoodRectangle2.
//================================================================================

class skTableWoodRectangle2 extends HPMeshActor;

//model import (skTableWoodRectangle2Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skTableWoodRectangle2Mesh ModelFile=Models\skTableWoodRectangle2Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skTableWoodRectangle2Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0

//anim import (skTableWoodRectangle2Anims) -AdamJD 
#exec Anim Import Anim=skTableWoodRectangle2Anims AnimFile=Models\skTableWoodRectangle2Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skTableWoodRectangle2Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skTableWoodRectangle2Mesh Anim=skTableWoodRectangle2Anims
#exec Anim Digest Anim=skTableWoodRectangle2Anims VERBOSE 

//texture import (skTableWoodRectangle2Tex0) -AdamJD 
#exec Texture Import File=Textures\skTableWoodRectangle2Tex0.png Name=skTableWoodRectangle2Tex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skTableWoodRectangle2Mesh Num=0 Texture=skTableWoodRectangle2Tex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skTableWoodRectangle2Mesh
}
