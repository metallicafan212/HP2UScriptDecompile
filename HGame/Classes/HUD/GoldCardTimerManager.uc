//================================================================================
// GoldCardTimerManager.
//================================================================================

class GoldCardTimerManager extends CountdownTimerManager;

// Omega: Obsolete
//const strFULL_BAR= "HP2_Menu.Icon.HP2GoldCardTimerFull";
//const strTIMER_EMPTY= "HP2_Menu.Icon.HP2GoldCardTimerEmpty";

// Omega: Use from parent instead, this will load hardcoded values
/*function LoadTimerBarGraphics()
{
  fFULL_OFFSET_X = 55.0;
  fFULL_OFFSET_Y = 22.0;
  textureTimerEmpty = Texture(DynamicLoadObject(strTIMER_EMPTY,Class'Texture'));
  textureFullBar = Texture(DynamicLoadObject(strFULL_BAR,Class'Texture'));
}*/

defaultproperties
{
    CutName="GoldCardTimerManager"
	
	// Omega: New properties
	strTextureTimerEmpty="HP2_Menu.Icon.HP2GoldCardTimerEmpty"
	strTextureFullBar="HP2_Menu.Icon.HP2GoldCardTimerFull"

	fFULL_OFFSET_X=55.0
	fFULL_OFFSET_Y=22.0
}
