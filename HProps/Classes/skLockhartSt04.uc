//================================================================================
// skLockhartSt04.
//================================================================================

class skLockhartSt04 extends HPMeshActor;

//model import (skLockhartSt04Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skLockhartSt04Mesh ModelFile=Models\skLockhartSt04Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skLockhartSt04Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skLockhartSt04Anims) -AdamJD 
#exec Anim Import Anim=skLockhartSt04Anims AnimFile=Models\skLockhartSt04Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skLockhartSt04Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skLockhartSt04Mesh Anim=skLockhartSt04Anims
#exec Anim Digest Anim=skLockhartSt04Anims VERBOSE 

//texture import (skLockhartSt04Tex0) -AdamJD 
#exec Texture Import File=Textures\skLockhartSt04Tex0.png Name=skLockhartSt04Tex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skLockhartSt04Mesh Num=0 Texture=skLockhartSt04Tex0

//texture import (skLockhartSt04Tex1) -AdamJD 
#exec Texture Import File=Textures\skLockhartSt04Tex1.png Name=skLockhartSt04Tex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skLockhartSt04Mesh Num=1 Texture=skLockhartSt04Tex1

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skLockhartSt04Mesh
}
