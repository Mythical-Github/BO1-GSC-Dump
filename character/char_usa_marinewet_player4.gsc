
main()
{
	self setModel("char_usa_marine_player_wet_body2_1");
	self.headModel = "char_usa_marine_head4_4";
	self attach(self.headModel, "", true);
	self.hatModel = "char_usa_raider_wet_helm2";
	self attach(self.hatModel);
	self.gearModel = "char_usa_raider_wet_gear3";
	self attach(self.gearModel, "", true);
	self.voice = "american";
	self.skeleton = "base";
}
precache()
{
	precacheModel("char_usa_marine_player_wet_body2_1");
	precacheModel("char_usa_marine_head4_4");
	precacheModel("char_usa_raider_wet_helm2");
	precacheModel("char_usa_raider_wet_gear3");
} 
