#include common_scripts\utility;
#include animscripts\Utility;
#include maps\_anim;

// --------------------------------------------------------------------------------
// ---- Animation setup functions ----
// --------------------------------------------------------------------------------
#using_animtree( "generic_human" );
setup_prisoners_override_animations()
{
	// run cycles for prisoners
	level.prisoner["stand"]["prisoner_run_cycle"] = array( 
														  %ai_prisoner_run_upright,
														  %ai_prisoner_run_hunched_A,
														  %ai_prisoner_run_hunched_B,
														  %ai_prisoner_run_hunched_C														  
														 );
}
