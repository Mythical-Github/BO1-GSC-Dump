// THIS FILE IS AUTOGENERATED, DO NOT MODIFY
/*QUAKED actor_TEMP_char_showcase_4 (0.0 0.25 1.0) (-16 -16 0) (16 16 72) SPAWNER MAKEROOM UNDELETABLE ENEMYINFO SCRIPT_FORCESPAWN SM_PRIORITY
defaultmdl="char_usa_marine_polonsky"
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
	self.team = "allies";
	self.type = "human";
	self.accuracy = 1;
	self.health = 150;
	self.weapon = "m16_sp";
	self.secondaryweapon = "";
	self.sidearm = "m1911_sp";
	self.grenadeWeapon = "frag_grenade_sp";
	self.grenadeAmmo = 0;
	self.csvInclude = "";

	self setEngagementMinDist( 250.000000, 0.000000 );
	self setEngagementMaxDist( 700.000000, 1000.000000 );

	switch( codescripts\character::get_random_character(3) )
	{
	case 0:
		character\c_rus_military1::main();
		break;
	case 1:
		character\c_rus_military2::main();
		break;
	case 2:
		character\c_rus_military3::main();
		break;
	}
}

spawner()
{
	self setspawnerteam("allies");
}

precache()
{
	character\c_rus_military1::precache();
	character\c_rus_military2::precache();
	character\c_rus_military3::precache();

	precacheItem("m16_sp");
	precacheItem("m1911_sp");
	precacheItem("frag_grenade_sp");
}
