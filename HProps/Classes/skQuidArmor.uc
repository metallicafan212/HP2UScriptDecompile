//================================================================================
// skQuidArmor.
//================================================================================

class skQuidArmor extends HPMeshActor;

//model import (skQuidArmorMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skQuidArmorMesh ModelFile=Models\skQuidArmorMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skQuidArmorMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skQuidArmorAnims) -AdamJD 
#exec Anim Import Anim=skQuidArmorAnims AnimFile=Models\skQuidArmorAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skQuidArmorMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skQuidArmorMesh Anim=skQuidArmorAnims
#exec Anim Digest Anim=skQuidArmorAnims VERBOSE 

//texture import (skQuidArmorTex0) -AdamJD 
#exec Texture Import File=Textures\skQuidArmorTex0.png Name=skQuidArmorTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skQuidArmorMesh Num=0 Texture=skQuidArmorTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skQuidArmorMesh
}
