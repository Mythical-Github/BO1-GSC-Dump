
main()
{
	self setModel("char_ger_ansel_body");
	self.headModel = "char_ger_ansel_head";
	self attach(self.headModel, "", true);
	self.hatModel = "char_ger_waffen_officercap1";
	self attach(self.hatModel);
	self.voice = "german";
	self.skeleton = "base";
}
precache()
{
	precacheModel("char_ger_ansel_body");
	precacheModel("char_ger_ansel_head");
	precacheModel("char_ger_waffen_officercap1");
} 
