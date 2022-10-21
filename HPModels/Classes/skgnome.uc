//================================================================================
// skgnome.
//================================================================================

class skgnome extends HPMesh
  Abstract;
  
//model import (skgnomeMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skgnomeMesh ModelFile=Models\skgnomeMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skgnomeMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skgnomeAnims) -AdamJD 
#exec Anim Import Anim=skgnomeAnims AnimFile=Models\skgnomeAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skgnomeMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skgnomeMesh Anim=skgnomeAnims
#exec Anim Digest Anim=skgnomeAnims VERBOSE 

//texture import (skgnomeTex0) -AdamJD 
#exec Texture Import File=Textures\skgnomeTex0.png Name=skgnomeTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skgnomeMesh Num=0 Texture=skgnomeTex0

//texture import (skgnomeTex1) -AdamJD 
#exec Texture Import File=Textures\skgnomeTex1.png Name=skgnomeTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skgnomeMesh Num=1 Texture=skgnomeTex1

//texture import (skgnomeTex2) -AdamJD 
#exec Texture Import File=Textures\skgnomeTex2.png Name=skgnomeTex2 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skgnomeMesh Num=2 Texture=skgnomeTex2

//anim notify imports -AdamJD
#exec Anim Notify Anim=skgnomeAnims Seq=runattack Time=0.99 Function=PlayFootStep
#exec Anim Notify Anim=skgnomeAnims Seq=runattack Time=0.5 Function=PlayFootStep
#exec Anim Notify Anim=skgnomeAnims Seq=runscared Time=0.99 Function=PlayFootStep
#exec Anim Notify Anim=skgnomeAnims Seq=runscared Time=0.5 Function=PlayFootStep
#exec Anim Notify Anim=skgnomeAnims Seq=runnormal Time=0.99 Function=PlayFootStep
#exec Anim Notify Anim=skgnomeAnims Seq=runnormal Time=0.5 Function=PlayFootStep

