
main()
{
	self setModel("char_rus_guard_player_body1_1");
	self.headModel = "char_rus_guard_head1_1";
	self attach(self.headModel, "", true);
	self.hatModel = "char_rus_guard_helm1";
	self attach(self.hatModel);
	self.gearModel = "char_rus_guard_body1_gear1_1";
	self attach(self.gearModel, "", true);
	self.voice = "russian";
	self.skeleton = "base";
}
precache()
{
	precacheModel("char_rus_guard_player_body1_1");
	precacheModel("char_rus_guard_head1_1");
	precacheModel("char_rus_guard_helm1");
	precacheModel("char_rus_guard_body1_gear1_1");
} 
