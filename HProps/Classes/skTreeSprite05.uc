//================================================================================
// skTreeSprite05.
//================================================================================

class skTreeSprite05 extends HPMeshActor;

//model import (skTreeSprite05Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skTreeSprite05Mesh ModelFile=Models\skTreeSprite05Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skTreeSprite05Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skTreeSprite05Anims) -AdamJD 
#exec Anim Import Anim=skTreeSprite05Anims AnimFile=Models\skTreeSprite05Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skTreeSprite05Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skTreeSprite05Mesh Anim=skTreeSprite05Anims
#exec Anim Digest Anim=skTreeSprite05Anims VERBOSE 

//texture import (skTreeSprite05Tex0) -AdamJD 
#exec Texture Import File=Textures\skTreeSprite05Tex0.png Name=skTreeSprite05Tex0 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skTreeSprite05Mesh Num=0 Texture=skTreeSprite05Tex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skTreeSprite05Mesh
}
