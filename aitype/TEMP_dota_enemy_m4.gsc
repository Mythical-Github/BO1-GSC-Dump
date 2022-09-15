// THIS FILE IS AUTOGENERATED, DO NOT MODIFY
/*QUAKED actor_TEMP_dota_enemy_m4 (1.0 0.25 0.0) (-16 -16 0) (16 16 72) SPAWNER MAKEROOM UNDELETABLE ENEMYINFO SCRIPT_FORCESPAWN SM_PRIORITY
defaultmdl="char_jap_impinf_officer_body"
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
	self.weapon = "";
	self.secondaryweapon = "m1911_sp";
	self.sidearm = "m1911_sp";
	self.grenadeWeapon = "frag_grenade_sp";
	self.grenadeAmmo = 0;
	self.csvInclude = "";

	self setEngagementMinDist( 128.000000, 0.000000 );
	self setEngagementMaxDist( 512.000000, 1024.000000 );

	character\char_rus_r_ppsh::main();
}

spawner()
{
	self setspawnerteam("axis");
}

precache()
{
	character\char_rus_r_ppsh::precache();

	precacheItem("m1911_sp");
	precacheItem("m1911_sp");
	precacheItem("frag_grenade_sp");
}
