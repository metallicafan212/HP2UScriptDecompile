//================================================================================
// skStatueGregorySmarmy.
//================================================================================

class skStatueGregorySmarmy extends HPMeshActor;

//model import (skStatueGregorySmarmyMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skStatueGregorySmarmyMesh ModelFile=Models\skStatueGregorySmarmyMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skStatueGregorySmarmyMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skStatueGregorySmarmyAnims) -AdamJD 
#exec Anim Import Anim=skStatueGregorySmarmyAnims AnimFile=Models\skStatueGregorySmarmyAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skStatueGregorySmarmyMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skStatueGregorySmarmyMesh Anim=skStatueGregorySmarmyAnims
#exec Anim Digest Anim=skStatueGregorySmarmyAnims VERBOSE 

//texture import (skStatueGregorySmarmyTex0) -AdamJD 
#exec Texture Import File=Textures\skStatueGregorySmarmyTex0.png Name=skStatueGregorySmarmyTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skStatueGregorySmarmyMesh Num=0 Texture=skStatueGregorySmarmyTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skStatueGregorySmarmyMesh
}
