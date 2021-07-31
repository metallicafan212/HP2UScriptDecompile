//================================================================================
// DirectionCamera.
//================================================================================

class DirectionCamera extends Actor;

//model import (DirectionCameraMesh) -AdamJD 
#exec Mesh ModelImport Mesh=DirectionCameraMesh ModelFile=Models\DirectionCameraMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=DirectionCameraMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (DirectionCameraAnims) -AdamJD 
#exec Anim Import Anim=DirectionCameraAnims AnimFile=Models\DirectionCameraAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=DirectionCameraMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=DirectionCameraMesh Anim=DirectionCameraAnims
#exec Anim Digest Anim=DirectionCameraAnims VERBOSE 

//texture import (DirectionCameraTex0) -AdamJD 
#exec Texture Import File=Textures\DirectionCameraTex0.png Name=DirectionCameraTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=DirectionCameraMesh Num=0 Texture=DirectionCameraTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=DirectionCameraMesh
}
