
main()
{
	self setModel("c_usa_jungmar_hudson_fb");
	self.headModel = "c_usa_jungmar_hudson_shades";
	self attach(self.headModel, "", true);
	self.voice = "american";
	self.skeleton = "base";
}
precache()
{
	precacheModel("c_usa_jungmar_hudson_fb");
	precacheModel("c_usa_jungmar_hudson_shades");
}  
