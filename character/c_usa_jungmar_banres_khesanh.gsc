
main()
{
	self setModel("c_usa_jungmar_barnes_ks_fb");
	self.hatModel = "c_usa_jungmar_barnes_ks_bdana";
	self attach(self.hatModel);
	self.voice = "american";
	self.skeleton = "base";
}
precache()
{
	precacheModel("c_usa_jungmar_barnes_ks_fb");
	precacheModel("c_usa_jungmar_barnes_ks_bdana");
}  
