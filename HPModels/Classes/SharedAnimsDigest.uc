//================================================================================
// SharedAnimsDigest.
//================================================================================

class SharedAnimsDigest extends Object
  Abstract;
  
//the shared anim digest imports -AdamJD
#exec Anim Digest Anim=NoAnims VERBOSE //NoAnims
#exec Anim Digest Anim=skbronzechestAnims VERBOSE //skbronzechestAnims
#exec Anim Digest Anim=skectoblobAnims VERBOSE //skectoblobAnims
#exec Anim Digest Anim=skGenFemaleAnims VERBOSE //skGenFemaleAnims
#exec Anim Digest Anim=skGenMaleAnims VERBOSE //skGenMaleAnims
#exec Anim Digest Anim=skGeorgeWeasleyAnims VERBOSE //skGeorgeWeasleyAnims
#exec Anim Digest Anim=skHarryAnims VERBOSE //skHarryAnims
#exec Anim Digest Anim=skHarryQuidAnims VERBOSE //skHarryQuidAnims
#exec Anim Digest Anim=skTomRiddleAnims VERBOSE //skTomRiddleAnims

//the shared anim notify imports -AdamJD
#exec Anim Notify Anim=skGenFemaleAnims Seq=run Time=0.99 Function=PlayFootStep //skGenFemaleAnims
#exec Anim Notify Anim=skGenFemaleAnims Seq=run Time=0.5 Function=PlayFootStep //skGenFemaleAnims
#exec Anim Notify Anim=skGenFemaleAnims Seq=Walk Time=0.99 Function=PlayFootStep //skGenFemaleAnims
#exec Anim Notify Anim=skGenFemaleAnims Seq=Walk Time=0.5 Function=PlayFootStep //skGenFemaleAnims
#exec Anim Notify Anim=skGenMaleAnims Seq=run Time=0.99 Function=PlayFootStep //skGenMaleAnims
#exec Anim Notify Anim=skGenMaleAnims Seq=run Time=0.5 Function=PlayFootStep //skGenMaleAnims
#exec Anim Notify Anim=skGenMaleAnims Seq=Walk Time=0.99 Function=PlayFootStep //skGenMaleAnims
#exec Anim Notify Anim=skGenMaleAnims Seq=Walk Time=0.5 Function=PlayFootStep //skGenMaleAnims
#exec Anim Notify Anim=skHarryAnims Seq=Cast Time=0.1 Function=Cast //skHarryAnims
#exec Anim Notify Anim=skHarryAnims Seq=SwordCast Time=0.1 Function=Cast //skHarryAnims

