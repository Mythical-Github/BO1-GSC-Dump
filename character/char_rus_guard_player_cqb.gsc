
main()
{
	self setModel("char_rus_guard_player_body_cqb");
	self.headModel = "char_rus_guard_player_head_cqb";
	self attach(self.headModel, "", true);
	self setViewmodel("viewhands_force_recon");
	self.voice = "russian";
	self.skeleton = "base";
	self.torsoDmg1 = "char_rus_guard_body2_m_g_upclean";
	self.torsoDmg2 = codescripts\character::randomElement(xmodelalias\char_rus_guard2_m_g_rarmoffalias::main());
	self.torsoDmg3 = codescripts\character::randomElement(xmodelalias\char_rus_guard2_m_g_larmoffalias::main());
	self.torsoDmg4 = codescripts\character::randomElement(xmodelalias\char_rus_guard2_m_g_torsoalias::main());
	self.torsoDmg5 = "char_rus_guard_body2_m_g_behead";
	self.legDmg1 = "char_rus_guard_body2_m_g_lowclean";
	self.legDmg2 = codescripts\character::randomElement(xmodelalias\char_rus_guard2_m_g_rlegoffalias::main());
	self.legDmg3 = codescripts\character::randomElement(xmodelalias\char_rus_guard2_m_g_llegoffalias::main());
	self.legDmg4 = codescripts\character::randomElement(xmodelalias\char_rus_guard2_m_g_legsoffalias::main());
	self.gibSpawn1 = "char_rus_guard_body1_m_g_rarmspawn";
	self.gibSpawnTag1 = "J_Elbow_RI";
	self.gibSpawn2 = "char_rus_guard_body1_m_g_larmspawn";
	self.gibSpawnTag2 = "J_Elbow_LE";
	self.gibSpawn3 = "char_rus_guard_body1_m_g_rlegspawn";
	self.gibSpawnTag3 = "J_Knee_RI";
	self.gibSpawn4 = "char_rus_guard_body1_m_g_llegspawn";
	self.gibSpawnTag4 = "J_Knee_LE";
}
precache()
{
	precacheModel("char_rus_guard_player_body_cqb");
	precacheModel("char_rus_guard_player_head_cqb");
	precacheModel("viewhands_force_recon");
	precacheModel("char_rus_guard_body2_m_g_upclean");
	codescripts\character::precacheModelArray(xmodelalias\char_rus_guard2_m_g_rarmoffalias::main());
	codescripts\character::precacheModelArray(xmodelalias\char_rus_guard2_m_g_larmoffalias::main());
	codescripts\character::precacheModelArray(xmodelalias\char_rus_guard2_m_g_torsoalias::main());
	precacheModel("char_rus_guard_body2_m_g_behead");
	precacheModel("char_rus_guard_body2_m_g_lowclean");
	codescripts\character::precacheModelArray(xmodelalias\char_rus_guard2_m_g_rlegoffalias::main());
	codescripts\character::precacheModelArray(xmodelalias\char_rus_guard2_m_g_llegoffalias::main());
	codescripts\character::precacheModelArray(xmodelalias\char_rus_guard2_m_g_legsoffalias::main());
	precacheModel("char_rus_guard_body1_m_g_rarmspawn");
	precacheModel("char_rus_guard_body1_m_g_larmspawn");
	precacheModel("char_rus_guard_body1_m_g_rlegspawn");
	precacheModel("char_rus_guard_body1_m_g_llegspawn");
	precacheModel("char_rus_guard_body2_m_g_upclean");
	codescripts\character::precacheModelArray(xmodelalias\char_rus_guard2_m_g_rarmoffalias::main());
	codescripts\character::precacheModelArray(xmodelalias\char_rus_guard2_m_g_larmoffalias::main());
	codescripts\character::precacheModelArray(xmodelalias\char_rus_guard2_m_g_torsoalias::main());
	precacheModel("char_rus_guard_body2_m_g_behead");
	precacheModel("char_rus_guard_body2_m_g_lowclean");
	codescripts\character::precacheModelArray(xmodelalias\char_rus_guard2_m_g_rlegoffalias::main());
	codescripts\character::precacheModelArray(xmodelalias\char_rus_guard2_m_g_llegoffalias::main());
	codescripts\character::precacheModelArray(xmodelalias\char_rus_guard2_m_g_legsoffalias::main());
	precacheModel("char_rus_guard_body1_m_g_rarmspawn");
	precacheModel("char_rus_guard_body1_m_g_larmspawn");
	precacheModel("char_rus_guard_body1_m_g_rlegspawn");
	precacheModel("char_rus_guard_body1_m_g_llegspawn");
} 
