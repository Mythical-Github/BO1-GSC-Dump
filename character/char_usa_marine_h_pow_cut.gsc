
main()
{
	self setModel("char_usa_marine_pow_body");
	self.headModel = "char_usa_marine_pow_head_cut";
	self attach(self.headModel, "", true);
	self.gearModel = "char_usa_marine_pow_cuffs";
	self attach(self.gearModel, "", true);
	self.voice = "american";
	self.skeleton = "base";
}
precache()
{
	precacheModel("char_usa_marine_pow_body");
	precacheModel("char_usa_marine_pow_head_cut");
	precacheModel("char_usa_marine_pow_cuffs");
} 
