//================================================================================
// skTreeSprite02.
//================================================================================

class skTreeSprite02 extends HPMeshActor;

//model import (skTreeSprite02Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skTreeSprite02Mesh ModelFile=Models\skTreeSprite02Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skTreeSprite02Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skTreeSprite02Anims) -AdamJD 
#exec Anim Import Anim=skTreeSprite02Anims AnimFile=Models\skTreeSprite02Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skTreeSprite02Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skTreeSprite02Mesh Anim=skTreeSprite02Anims
#exec Anim Digest Anim=skTreeSprite02Anims VERBOSE 

//texture import (skTreeSprite02Tex0) -AdamJD 
#exec Texture Import File=Textures\skTreeSprite02Tex0.png Name=skTreeSprite02Tex0 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skTreeSprite02Mesh Num=0 Texture=skTreeSprite02Tex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skTreeSprite02Mesh
}
