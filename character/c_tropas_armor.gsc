
main()
{
	self setModel("c_cub_tropas_mp_body_armor_demo");
	self.headModel = "c_cub_tropas_mp_head_1_demo";
	self attach(self.headModel, "", true);
	self.voice = "cuban";
	self.skeleton = "base";
}
precache()
{
	precacheModel("c_cub_tropas_mp_body_armor_demo");
	precacheModel("c_cub_tropas_mp_head_1_demo");
}  
