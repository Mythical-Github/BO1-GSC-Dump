
main()
{
	self setModel("c_usa_jungmar_body_drab");
	self.headModel = "c_usa_jungmar_head1_nc";
	self attach(self.headModel, "", true);
	self.gearModel = "c_usa_jungmar_bandage_torso";
	self attach(self.gearModel, "", true);
	self.voice = "american";
	self.skeleton = "base";
}
precache()
{
	precacheModel("c_usa_jungmar_body_drab");
	precacheModel("c_usa_jungmar_head1_nc");
	precacheModel("c_usa_jungmar_bandage_torso");
}  
