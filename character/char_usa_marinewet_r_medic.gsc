
main()
{
	self setModel("char_usa_marine_wet_corpsman_body");
	self.headModel = "char_usa_marine_corpsman_head";
	self attach(self.headModel, "", true);
	self.hatModel = "char_usa_marine_wet_helmm";
	self attach(self.hatModel);
	self.voice = "american";
	self.skeleton = "base";
}
precache()
{
	precacheModel("char_usa_marine_wet_corpsman_body");
	precacheModel("char_usa_marine_corpsman_head");
	precacheModel("char_usa_marine_wet_helmm");
} 
