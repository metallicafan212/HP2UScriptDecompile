//================================================================================
// skCoatRack1.
//================================================================================

class skCoatRack1 extends HPMeshActor;

//model import (skCoatRack1Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skCoatRack1Mesh ModelFile=Models\skCoatRack1Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skCoatRack1Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skCoatRack1Anims) -AdamJD 
#exec Anim Import Anim=skCoatRack1Anims AnimFile=Models\skCoatRack1Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skCoatRack1Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skCoatRack1Mesh Anim=skCoatRack1Anims
#exec Anim Digest Anim=skCoatRack1Anims VERBOSE 

//texture import (skCoatRack1Tex0) -AdamJD 
#exec Texture Import File=Textures\skCoatRack1Tex0.png Name=skCoatRack1Tex0 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 MaskedOverride=(R=255,G=0,B=255,A=255) Group=Skins 
#exec MeshMap SetTexture MeshMap=skCoatRack1Mesh Num=0 Texture=skCoatRack1Tex0

//texture import (skCoatRack1Tex1) -AdamJD 
#exec Texture Import File=Textures\skCoatRack1Tex1.png Name=skCoatRack1Tex1 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 MaskedOverride=(R=255,G=0,B=255,A=255) Group=Skins 
#exec MeshMap SetTexture MeshMap=skCoatRack1Mesh Num=1 Texture=skCoatRack1Tex1

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skCoatRack1Mesh
}
