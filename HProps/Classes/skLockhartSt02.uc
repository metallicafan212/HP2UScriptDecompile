//================================================================================
// skLockhartSt02.
//================================================================================

class skLockhartSt02 extends HPMeshActor;

//model import (skLockhartSt02Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skLockhartSt02Mesh ModelFile=Models\skLockhartSt02Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skLockhartSt02Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skLockhartSt02Anims) -AdamJD 
#exec Anim Import Anim=skLockhartSt02Anims AnimFile=Models\skLockhartSt02Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skLockhartSt02Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skLockhartSt02Mesh Anim=skLockhartSt02Anims
#exec Anim Digest Anim=skLockhartSt02Anims VERBOSE 

//texture import (skLockhartSt02Tex0) -AdamJD 
#exec Texture Import File=Textures\skLockhartSt02Tex0.png Name=skLockhartSt02Tex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skLockhartSt02Mesh Num=0 Texture=skLockhartSt02Tex0

//texture import (skLockhartSt02Tex1) -AdamJD 
#exec Texture Import File=Textures\skLockhartSt02Tex1.png Name=skLockhartSt02Tex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skLockhartSt02Mesh Num=1 Texture=skLockhartSt02Tex1

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skLockhartSt02Mesh
}
