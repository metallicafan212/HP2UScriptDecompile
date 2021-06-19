//================================================================================
// DirectionFeet.
//================================================================================

class DirectionFeet extends Actor;

//model import (DirectionFeetMesh) -AdamJD 
#exec Mesh ModelImport Mesh=DirectionFeetMesh ModelFile=Models\DirectionFeetMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=DirectionFeetMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0
//this is meant to be invisible -AdamJD 

//shared anim import (NoAnims) -AdamJD
#exec MeshMap Scale MeshMap=DirectionFeetMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=DirectionFeetMesh Anim=NoAnims

//texture import (DirectionFeetTex0) -AdamJD 
#exec Texture Import File=Textures\DirectionFeetTex0.png Name=DirectionFeetTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=DirectionFeetMesh Num=0 Texture=DirectionFeetTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=DirectionFeetMesh
}
