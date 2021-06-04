//================================================================================
// skSnakeBeam.
//================================================================================

class skSnakeBeam extends HPMeshActor;

//model import (skSnakeBeamMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skSnakeBeamMesh ModelFile=Models\skSnakeBeamMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skSnakeBeamMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skSnakeBeamAnims) -AdamJD 
#exec Anim Import Anim=skSnakeBeamAnims AnimFile=Models\skSnakeBeamAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skSnakeBeamMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skSnakeBeamMesh Anim=skSnakeBeamAnims
#exec Anim Digest Anim=skSnakeBeamAnims VERBOSE 

//KW didn't add a texture for skSnakeBeam -AdamJD

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skSnakeBeamMesh
}
