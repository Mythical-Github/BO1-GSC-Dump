
main()
{
	self setModel("c_cub_rebels_mp_body_utility_demo");
	self.headModel = "c_cub_rebels_mp_head_5_demo";
	self attach(self.headModel, "", true);
	self.voice = "american";
	self.skeleton = "base";
}
precache()
{
	precacheModel("c_cub_rebels_mp_body_utility_demo");
	precacheModel("c_cub_rebels_mp_head_5_demo");
} 
