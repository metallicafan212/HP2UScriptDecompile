// Metallicafan212:	Custom object to draw over the background layer of menus
//					So I can update my cursed mod easily without having to merge a lot of changes
class M212CustBack extends object
	abstract;

// Metallicafan212:	Interface functions
static function BeforeBackgroundDraw(Canvas C, BaseFEPage P){}
static function AfterBackgroundLayer(Canvas C, BaseFEPage P){}
static function AfterLayering(Canvas C, BaseFEPage P){}