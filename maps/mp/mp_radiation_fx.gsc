#include maps\mp\_utility; 

// fx used by util scripts
precache_util_fx()
{
	
}

// Scripted effects
precache_scripted_fx()
{
	level._effect["blink_light"] = loadfx( "weapon/crossbow/fx_trail_crossbow_blink_red_os" );
	level._effect["red_light"] = loadfx( "env/light/fx_light_incandescent" );
	level._effect["green_light"] = loadfx( "weapon/crossbow/fx_trail_crossbow_blink_grn_os" );
	
}

// Ambient effects
precache_createfx_fx()
{
	level._effect["fx_acid_fizz_md"]											= loadfx("env/water/fx_acid_fizz_md");

	level._effect["fx_water_drip_light_long"]							= loadfx("env/water/fx_water_drip_light_long");	
	level._effect["fx_water_drip_light_short"]						= loadfx("env/water/fx_water_drip_light_short");	
	
	level._effect["fx_emergency_lights_int"]							= loadfx("env/light/fx_emergency_lights_int");
	level._effect["fx_light_floodlight_bright"]						= loadfx("env/light/fx_light_floodlight_bright");		
	level._effect["fx_light_floodlight_dim"]							= loadfx("env/light/fx_light_floodlight_dim");
	level._effect["fx_light_ray_fire_ribbon_sm"]					= loadfx("maps/mp_maps/fx_mp_light_ray_fire_ribbon_sm");
//	level._effect["fx_light_ray_blue_ribbon_sm"]					= loadfx("maps/mp_maps/fx_mp_light_ray_blue_ribbon_sm");
	level._effect["fx_light_ray_fan"]											= loadfx("env/light/fx_light_ray_fan");
	level._effect["fx_light_office_light_01"]							= loadfx("env/light/fx_light_office_light_02");
	level._effect["fx_light_office_light_03"]							= loadfx("env/light/fx_light_office_light_03");
//	level._effect["fx_light_floodlight_int_yllw"]					= loadfx("env/light/fx_light_floodlight_int_yllw");	
//	level._effect["fx_light_floodlight_int_blue"]					= loadfx("env/light/fx_light_floodlight_int_blue");	
	level._effect["fx_light_tinhat_cage_white"]						= loadfx("env/light/fx_light_tinhat_cage_white");		
	
	level._effect["fx_mp_light_gray_warm_lrg"]						= loadfx("maps/mp_maps/fx_mp_light_gray_warm_lrg");		
	level._effect["fx_mp_light_gray_warm_sm"]							= loadfx("maps/mp_maps/fx_mp_light_gray_warm_sm");		
	level._effect["fx_mp_light_gray_warm_md"]							= loadfx("maps/mp_maps/fx_mp_light_gray_warm_md");	
	
//	level._effect["fx_light_dust_motes_sm"]								= loadfx("env/light/fx_light_dust_motes_sm");
	level._effect["fx_mp_light_dust_motes_md"]						= loadfx("maps/mp_maps/fx_mp_light_dust_motes_md");
	
	level._effect["fx_fumes_vent_sm"]											= loadfx("maps/mp_maps/fx_mp_fumes_vent_sm");
//	level._effect["fx_fumes_haze_md"]											= loadfx("maps/mp_maps/fx_mp_fumes_haze_md");	
	level._effect["fx_smk_vent"]													= loadfx("maps/mp_maps/fx_mp_smk_vent");
	level._effect["fx_mp_smk_plume_md_wht_wispy"]					= loadfx("maps/mp_maps/fx_mp_smk_plume_md_wht_wispy");	
	level._effect["fx_mp_smk_tin_hat_steam_pipe"]					= loadfx("maps/mp_maps/fx_mp_smk_tin_hat_steam_pipe");	
//	level._effect["fx_smk_field_sm"]											= loadfx("env/smoke/fx_smk_field_sm");
	level._effect["fx_smk_linger_lit"]										= loadfx("maps/mp_maps/fx_mp_smk_linger");
//	level._effect["fx_smk_plume_lg_white"]								= loadfx("env/smoke/fx_smk_plume_lg_white");	
//	level._effect["fx_smk_smolder_sm"]										= loadfx("env/smoke/fx_smk_smolder_sm");
	
//	level._effect["fx_mp_radiation_steam"]								= loadfx("maps/mp_maps/fx_mp_radiation_steam");	
	level._effect["fx_pipe_steam_md"]											= loadfx("env/smoke/fx_pipe_steam_md");
	
//	level._effect["fx_sand_blowing_lg_w"]									= loadfx("env/dirt/fx_sand_blowing_lg_w");	
//	level._effect["fx_sand_blowing_sm"]										= loadfx("env/dirt/fx_sand_blowing_sm");
	level._effect["fx_sand_rising_xlg"]										= loadfx("env/dirt/fx_sand_rising_xlg");

//	level._effect["fx_sand_windy_fast_sm_os"]							= loadfx("maps/mp_maps/fx_mp_sand_windy_fast_sm_os");
	level._effect["fx_sand_windy_fast_door_os"]						= loadfx("maps/mp_maps/fx_mp_sand_windy_slow_door_os");
	level._effect["fx_sand_windy_heavy_sm"]								= loadfx("maps/mp_maps/fx_mp_sand_windy_heavy_sm_slow");
//	level._effect["fx_mp_sand_blowing_lg"]								= loadfx("maps/mp_maps/fx_mp_sand_blowing_lg");	
//	level._effect["fx_mp_sand_blowing_xlg"]								= loadfx("maps/mp_maps/fx_mp_sand_blowing_xlg");
	level._effect["fx_mp_sand_blowing_xlg_distant"]				= loadfx("maps/mp_maps/fx_mp_sand_blowing_xlg_distant");
	level._effect["fx_mp_sand_windy_pcloud_lg"]						= loadfx("maps/mp_maps/fx_mp_sand_windy_pcloud_lg_slow");	
	
	level._effect["fx_mp_dust_conveyor"]									= loadfx("maps/mp_maps/fx_mp_dust_conveyor");
		
//	level._effect["fx_mp_distortion_heat_field_lg"]				= loadfx("maps/mp_maps/fx_mp_distortion_heat_field_lg");		
//	level._effect["fx_mp_distortion_heat_field_sm"]				= loadfx("maps/mp_maps/fx_mp_distortion_heat_field_sm");
	
	level._effect["fx_mp_elec_spark_burst_sm"]						= loadfx("maps/mp_maps/fx_mp_elec_spark_burst_sm");
	level._effect["fx_mp_elec_spark_burst_xsm_thin"]			= loadfx("maps/mp_maps/fx_mp_elec_spark_burst_xsm_thin");
	level._effect["fx_mp_elec_spark_burst_lg"]						= loadfx("maps/mp_maps/fx_mp_elec_spark_burst_lg");	
	
	level._effect["fx_debris_papers"]											= loadfx("env/debris/fx_debris_papers");
	
	level._effect["fx_light_beacon_yllw_distant"]					= loadfx("env/light/fx_light_beacon_yllw_distant_sm");	
	level._effect["fx_light_beacon_red_distant_fst"]			= loadfx("env/light/fx_light_beacon_red_distant_fst");	

	level._effect["fx_mp_sand_digger_radiation"]					= loadfx("maps/mp_maps/fx_mp_sand_digger_radiation");	
	
	level._effect["fx_light_panel_green"]									= loadfx("env/light/fx_light_panel_green");	
	level._effect["fx_light_panel_red"]										= loadfx("env/light/fx_light_panel_red");	
}

wind_initial_setting()
{
SetDvar( "enable_global_wind", 1); // enable wind for your level
SetDvar( "wind_global_vector", "-90 -80 -80" );    // change "0 0 0" to your wind vector
SetDvar( "wind_global_low_altitude", -175);    // change 0 to your wind's lower bound
SetDvar( "wind_global_hi_altitude", 4000);    // change 10000 to your wind's upper bound
SetDvar( "wind_global_low_strength_percent", .5);    // change 0.5 to your desired wind strength percentage
}

main()
{
	// art file would be called here
	
	precache_util_fx();
	precache_createfx_fx();
	precache_scripted_fx();
	maps\mp\createfx\mp_radiation_fx::main();
  maps\mp\createart\mp_radiation_art::main();
  
  wind_initial_setting();
}