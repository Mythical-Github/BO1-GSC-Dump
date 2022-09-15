// THIS FILE IS AUTOGENERATED, DO NOT MODIFY
/*QUAKED actor_VC_e_Creek_Meatshield (1.0 0.25 0.0) (-16 -16 0) (16 16 72) SPAWNER MAKEROOM UNDELETABLE ENEMYINFO SCRIPT_FORCESPAWN SM_PRIORITY
defaultmdl="c_vtn_vc1_fullbody"
"count" -- max AI to ever spawn from this spawner
SPAWNER -- makes this a spawner instead of a guy
MAKEROOM -- will try to delete an AI if spawning fails from too many AI
UNDELETABLE -- this AI (or AI spawned from here) cannot be deleted to make room for MAKEROOM guys
ENEMYINFO -- this AI when spawned will get a snapshot of perfect info about all enemies
SCRIPT_FORCESPAWN -- this AI will spawned even if players can see him spawning.
SM_PRIORITY -- Make the Spawn Manager spawn from this spawner before other spawners.
*/
main()
{
	self.animTree = "";
	self.team = "axis";
	self.type = "human";
	self.accuracy = 1;
	self.health = 150;
	self.weapon = "ak47_sp";
	self.secondaryweapon = "";
	self.sidearm = "makarov_sp";
	self.grenadeWeapon = "frag_grenade_sp";
	self.grenadeAmmo = 2;
	self.csvInclude = "char_vc.csv";

	self setEngagementMinDist( 500.000000, 400.000000 );
	self setEngagementMaxDist( 1000.000000, 1200.000000 );

	character\c_vtn_vc1_meatshield::main();
}

spawner()
{
	self setspawnerteam("axis");
}

precache()
{
	character\c_vtn_vc1_meatshield::precache();

	precacheItem("ak47_sp");
	precacheItem("makarov_sp");
	precacheItem("frag_grenade_sp");
}
