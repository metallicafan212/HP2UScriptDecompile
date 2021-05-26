//================================================================================
// skLockhartSt03.
//================================================================================

class skLockhartSt03 extends HPMeshActor;

//model import (skLockhartSt03Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skLockhartSt03Mesh ModelFile=Models\skLockhartSt03Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skLockhartSt03Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skLockhartSt03Anims) -AdamJD 
#exec Anim Import Anim=skLockhartSt03Anims AnimFile=Models\skLockhartSt03Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skLockhartSt03Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skLockhartSt03Mesh Anim=skLockhartSt03Anims
#exec Anim Digest Anim=skLockhartSt03Anims VERBOSE 

//texture import (skLockhartSt03Tex0) -AdamJD 
#exec Texture Import File=Textures\skLockhartSt03Tex0.png Name=skLockhartSt03Tex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skLockhartSt03Mesh Num=0 Texture=skLockhartSt03Tex0

//texture import (skLockhartSt03Tex1) -AdamJD 
#exec Texture Import File=Textures\skLockhartSt03Tex1.png Name=skLockhartSt03Tex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skLockhartSt03Mesh Num=1 Texture=skLockhartSt03Tex1

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skLockhartSt03Mesh
}
