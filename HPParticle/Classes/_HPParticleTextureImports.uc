//this is created by me to add the exec commands for finding the textures in one file instead of having to put them in each individual class -AdamJD
class _HPParticleTextureImports extends Actor 
	abstract;

//get the HPParticle textures -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx
#exec OBJ LOAD FILE=..\Textures\Particles.utx 	Package=HPParticle.particle_fx