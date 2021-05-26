//================================================================================
// skLockhartSt01.
//================================================================================

class skLockhartSt01 extends HPMeshActor;

//model import (skLockhartSt01Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skLockhartSt01Mesh ModelFile=Models\skLockhartSt01Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skLockhartSt01Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skLockhartSt01Anims) -AdamJD 
#exec Anim Import Anim=skLockhartSt01Anims AnimFile=Models\skLockhartSt01Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skLockhartSt01Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skLockhartSt01Mesh Anim=skLockhartSt01Anims
#exec Anim Digest Anim=skLockhartSt01Anims VERBOSE

//texture import (skLockhartSt01Tex0) -AdamJD 
#exec Texture Import File=Textures\skLockhartSt01Tex0.png Name=skLockhartSt01Tex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skLockhartSt01Mesh Num=0 Texture=skLockhartSt01Tex0

//texture import (skLockhartSt01Tex1) -AdamJD 
#exec Texture Import File=Textures\skLockhartSt01Tex1.png Name=skLockhartSt01Tex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skLockhartSt01Mesh Num=1 Texture=skLockhartSt01Tex1

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skLockhartSt01Mesh
}
