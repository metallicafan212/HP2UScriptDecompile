//================================================================================
// skStatueHunchbackWitch.
//================================================================================

class skStatueHunchbackWitch extends HPMeshActor;

//model import (skStatueHunchbackWitchMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skStatueHunchbackWitchMesh ModelFile=Models\skStatueHunchbackWitchMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skStatueHunchbackWitchMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skStatueHunchbackWitchAnims) -AdamJD 
#exec Anim Import Anim=skStatueHunchbackWitchAnims AnimFile=Models\skStatueHunchbackWitchAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skStatueHunchbackWitchMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skStatueHunchbackWitchMesh Anim=skStatueHunchbackWitchAnims
#exec Anim Digest Anim=skStatueHunchbackWitchAnims VERBOSE 

//texture import (skStatueHunchbackWitchTex0) -AdamJD 
#exec Texture Import File=Textures\skStatueHunchbackWitchTex0.png Name=skStatueHunchbackWitchTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skStatueHunchbackWitchMesh Num=0 Texture=skStatueHunchbackWitchTex0

//texture import (skStatueHunchbackWitchTex1) -AdamJD 
#exec Texture Import File=Textures\skStatueHunchbackWitchTex1.png Name=skStatueHunchbackWitchTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skStatueHunchbackWitchMesh Num=1 Texture=skStatueHunchbackWitchTex1

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skStatueHunchbackWitchMesh
}
