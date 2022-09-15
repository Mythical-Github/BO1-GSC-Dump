#include maps\_utility;
init()
{
	
	if ( !mayGenerateAfterActionReport() )
		return;
		
	cac_init();
	
	class_init();
	
	rank_init();
	
	level.xpScale = GetDvarInt( #"scr_xpscale" );
	buildChallegeInfo();
	buildMPChallengeInfo();
	level thread onPlayerConnect();
	
	level.missionCallbacks = [];
	precacheString(&"CHALLENGE_COOP_COMPLETED");
	precacheString(&"CHALLENGE_MULTIPLE_COOP_COMPLETED");
	precacheString(&"CHALLENGE_MULTIPLE_COOP_COMPLETED_DETAILS");	
	registerMissionCallback( "actorKilled", ::ch_kills );	
	registerMissionCallback( "playerRevived", ::ch_revives );
	registerMissionCallback( "playerDied", ::ch_dies );
	registerMissionCallback( "playerGib", ::ch_gib );
	registerMissionCallback( "levelEnd", ::ch_levelEnd );
	registerMissionCallback( "multiplierChanged", ::ch_multiplierChanged );
	registerMissionCallback( "checkpointLoaded", ::ch_checkpointLoaded );
	registerMissionCallback( "playerAssist", ::ch_assists );	
	
	
	
	
}
mayGenerateAfterActionReport()
{	
	if ( GetDvar( #"zombiemode" ) == "1" )
		return false;		
	if ( isCoopEPD() )
		return false;
	
	return level.rankedMatch;	
}
mayProcessChallenges()
{
	if ( GetDvar( #"zombiemode" ) == "1" )
		return false;		
	if ( isCoopEPD() )
		return false;
	
	return level.rankedMatch;
}
onPlayerConnect()
{
	for(;;)
	{
		level waittill( "connected", player );
		player.rankxp = player statGet( "rankxp" );
		rankId = player getRankForXp( player getRankXP() );
		player.rank = rankId;
	
		prestige = player getPrestigeLevel();
		player setRank( rankId, prestige );
		player.prestige = prestige;
		
		player.summary_xp = 0;
		player.summary_challenge = 0;
		
		
		player setClientDvars( 	"psn", player.playername,
								"psx", "0",
								"pss", "0",
								"psc", "0",
								"psk", "0",
								"psd", "0",
								"psr", "0",
								"psh", "0", 
								"psa", "0",								
								"ui_lobbypopup", "summary");
		
		
		
		
		player updateChallenges();
		player updateMPChallenges();
		ch_reset_alive_challenges( player );
		player thread ch_brassCollector();
		
		
		
		
		
		
		
	}
}
onSaveRestored()
{
	if ( !mayProcessChallenges() )
		return;
	players = get_players();
	for( i = 0; i < players.size; i++)
	{
		players[i].rankxp = players[i] statGet( "rankxp" );
		rankId = players[i] getRankForXp( players[i] getRankXP() );
		players[i].rank = rankId;
	
		prestige = players[i] getPrestigeLevel();
		players[i] setRank( rankId, prestige );
		players[i].prestige = prestige;
		
		players[i] updateChallenges();
		players[i] updateMPChallenges();		
	}
}
createCacheSummary()
{
	self.cached_summary_xp = 0;
	self.cached_score = 0;
	self.cached_summary_challenge = 0;
	self.cached_kills =  0;
	self.cached_downs = 0;
	self.cached_assists = 0;
	self.cached_headshots = 0;
	self.cached_revives = 0;
	
	self.summary_cache_created = true;
}
buildSummaryArray()
{
	summaryArray = [];
	if(self.cached_summary_xp != self.summary_xp)
	{
		summaryArray[summaryArray.size] = "psx";
		summaryArray[summaryArray.size] = self.summary_xp;
		self.cached_summary_xp = self.summary_xp;
	}	
	if(self.cached_score != self.score)
	{
		summaryArray[summaryArray.size] = "pss";
		summaryArray[summaryArray.size] = self.score;
		self.cached_score = self.score;
	}
	
	if(self.cached_summary_challenge != self.summary_challenge)
	{
		summaryArray[summaryArray.size] = "psc";
		summaryArray[summaryArray.size] = self.summary_challenge;
		self.cached_summary_challenge = self.summary_challenge;
	}
	
	if(self.cached_downs != self.downs)
	{
		summaryArray[summaryArray.size] = "psd";
		summaryArray[summaryArray.size] = self.downs;
		self.cached_downs = self.downs;
	}
	if(self.cached_headshots != self.headshots)
	{
		summaryArray[summaryArray.size] = "psh";
		summaryArray[summaryArray.size] = self.headshots;
		self.cached_headshots = self.headshots;
	}
	if(self.cached_kills != self.kills - self.headshots)
	{
		summaryArray[summaryArray.size] = "psk";
		summaryArray[summaryArray.size] = self.kills - self.headshots;
		self.cached_kills = self.kills - self.headshots;
	}
	
	if(self.cached_revives != self.revives)
	{
		summaryArray[summaryArray.size] = "psr";
		summaryArray[summaryArray.size] = self.revives;
		self.cached_revives = self.revives;
	}
	
	if(self.cached_assists != self.assists)
	{
		summaryArray[summaryArray.size] = "psa";
		summaryArray[summaryArray.size] = self.assists;
		self.cached_assists = self.assists;
	}	
		
	return summaryArray;
}
updateMatchSummary( callback )
{
	forceUpdate = ( IsDefined(callback) && (callback == "levelEnd" || callback == "checkpointLoaded") );
	if( OkToSpawn() || forceUpdate )
	{
		if( !isdefined(self.summary_cache_created) || callback == "checkpointLoaded" )
		{
			self createCacheSummary();
		}
	
		summary = self buildSummaryArray();
		
		if(summary.size > 0)
		{
			switch(summary.size)	
			{
				case 2:
					self setClientDvars(summary[0], summary[1]);
					break;
				case 4:
					self setClientDvars(summary[0], summary[1], summary[2], summary[3]);
					break;
				case 6:
					self setClientDvars(summary[0], summary[1], summary[2], summary[3], summary[4], summary[5]);
					break;
				case 8:
					self setClientDvars(summary[0], summary[1], summary[2], summary[3], summary[4], summary[5], summary[6], summary[7]);
					break;
				case 10:
					self setClientDvars(summary[0], summary[1], summary[2], summary[3], summary[4], summary[5], summary[6], summary[7], summary[8], summary[9]);
					break;
				case 12:
					self setClientDvars(summary[0], summary[1], summary[2], summary[3], summary[4], summary[5], summary[6], summary[7], summary[8], summary[9], summary[10], summary[11]);
					break;
				case 14:
					self setClientDvars(summary[0], summary[1], summary[2], summary[3], summary[4], summary[5], summary[6], summary[7], summary[8], summary[9], summary[10], summary[11], summary[12], summary[13]);
					break;
				case 16:
					self setClientDvars(summary[0], summary[1], summary[2], summary[3], summary[4], summary[5], summary[6], summary[7], summary[8], summary[9], summary[10], summary[11], summary[12], summary[13], summary[14], summary[15]);
					break;
				case 18:
					self setClientDvars(summary[0], summary[1], summary[2], summary[3], summary[4], summary[5], summary[6], summary[7], summary[8], summary[9], summary[10], summary[11], summary[12], summary[13], summary[14], summary[15], summary[16], summary[17]);
					break;
				default:
					assertex("Unexpected number of elements in summary array.");
			}
			
			println("*** Summary sent " + (summary.size / 2) + " elements.");
		}
		
	}
}
challengeTest()
{
	
}
registerMissionCallback(callback, func)
{
	if (!isdefined(level.missionCallbacks[callback]))
		level.missionCallbacks[callback] = [];
	level.missionCallbacks[callback][level.missionCallbacks[callback].size] = func;
}
getChallengeStatus( name )
{
	if ( isDefined( self.challengeData[name] ) )
		return self.challengeData[name];
	else
		return 0;
}
getChallengeLevels( baseName )
{
	if ( isDefined( level.challengeInfo[baseName] ) )
		return level.challengeInfo[baseName]["levels"];
		
	assertex( isDefined( level.challengeInfo[baseName + "1" ] ), "Challenge name " + baseName + " not found!" );
	
	return level.challengeInfo[baseName + "1"]["levels"];
}
challengeNotify( challengeName )
{
	notifyData = spawnStruct();
	notifyData.titleText = &"CHALLENGE_COOP_COMPLETED";
	notifyData.notifyText = challengeName;
	notifyData.sound = "mp_challenge_complete";
	
	self maps\_hud_message::notifyMessage( notifyData );
}
rank_init()
{
	
	level.rankTable = [];
	level.maxRank = int(tableLookup( "mp/rankTable.csv", 0, "maxrank", 1 ));
	level.maxPrestige = int(tableLookup( "mp/rankIconTable.csv", 0, "maxprestige", 1 ));
	pId = 0;
	rId = 0;
	
	for ( pId = 0; pId <= level.maxPrestige; pId++ )
	{
		for ( rId = 0; rId <= level.maxRank; rId++ )
			precacheShader( tableLookup( "mp/rankIconTable.csv", 0, rId, pId+1 ) );
	}
	rankId = 0;
	rankName = tableLookup( "mp/ranktable.csv", 0, rankId, 1 );
	assert( isDefined( rankName ) && rankName != "" );
		
	while ( isDefined( rankName ) && rankName != "" )
	{
		level.rankTable[rankId][1] = tableLookup( "mp/ranktable.csv", 0, rankId, 1 );
		level.rankTable[rankId][2] = tableLookup( "mp/ranktable.csv", 0, rankId, 2 );
		level.rankTable[rankId][3] = tableLookup( "mp/ranktable.csv", 0, rankId, 3 );
		level.rankTable[rankId][7] = tableLookup( "mp/ranktable.csv", 0, rankId, 7 );
		rankId++;
		rankName = tableLookup( "mp/ranktable.csv", 0, rankId, 1 );		
	}
	level.numChallengeTiers	= 0;
	level.numChallengeTiersMP = 0;
	
	precacheString( &"RANK_PLAYER_WAS_PROMOTED_N" );
	precacheString( &"RANK_PLAYER_WAS_PROMOTED" );
	precacheString( &"RANK_PROMOTED" );
	precacheString( &"MP_PLUS" );
	precacheString( &"RANK_ROMANI" );
	precacheString( &"RANK_ROMANII" );
	precacheString( &"RANK_ROMANIII" );
}
updateChallenges()
{
	self.challengeData = [];
	for ( i = 1; i <= level.numChallengeTiers; i++ )
	{
		
		tableName = "mp/challengetable_coop"+i+".csv";
		idx = 1;
		
		for( idx = 1; isdefined( tableLookup( tableName, 0, idx, 0 ) ) && tableLookup( tableName, 0, idx, 0 ) != ""; idx++ )
		{
			stat_num = tableLookup( tableName, 0, idx, 2 );
			if( isdefined( stat_num ) && stat_num != "" )
			{
				statVal = self getStat( int( stat_num ) );
				if( !statVal )
				{
					statVal = 1;
					self setStat( int( stat_num ), 1 );
				}
				
				refString = tableLookup( tableName, 0, idx, 7 );
				self.challengeData[refString] = statVal;
			}
		}
	}
}
buildChallegeInfo()
{
	level.challengeInfo = [];
	for ( i = 1; i <= level.numChallengeTiers; i++ )
	{
		
		tableName = "mp/challengetable_coop"+i+".csv";
		baseRef = "";
		
		for( idx = 1; isdefined( tableLookup( tableName, 0, idx, 0 ) ) && tableLookup( tableName, 0, idx, 0 ) != ""; idx++ )
		{
			stat_num = tableLookup( tableName, 0, idx, 2 );
			refString = tableLookup( tableName, 0, idx, 7 );
			level.challengeInfo[refString] = [];
			level.challengeInfo[refString]["tier"] = i;
			level.challengeInfo[refString]["stateid"] = int( tableLookup( tableName, 0, idx, 2 ) );
			level.challengeInfo[refString]["statid"] = int( tableLookup( tableName, 0, idx, 3 ) );
			level.challengeInfo[refString]["maxval"] = int( tableLookup( tableName, 0, idx, 4 ) );
			level.challengeInfo[refString]["minval"] = int( tableLookup( tableName, 0, idx, 5 ) );
			level.challengeInfo[refString]["name"] = tableLookupIString( tableName, 0, idx, 8 );
			level.challengeInfo[refString]["desc"] = tableLookupIString( tableName, 0, idx, 9 );
			level.challengeInfo[refString]["reward"] = int( tableLookup( tableName, 0, idx, 10 ) );
			
			
			
			precacheString( level.challengeInfo[refString]["name"] );
			if ( !int( level.challengeInfo[refString]["stateid"] ) )
			{
				level.challengeInfo[baseRef]["levels"]++;
				level.challengeInfo[refString]["stateid"] = level.challengeInfo[baseRef]["stateid"];
				level.challengeInfo[refString]["level"] = level.challengeInfo[baseRef]["levels"];
			}
			else
			{
				level.challengeInfo[refString]["levels"] = 1;
				level.challengeInfo[refString]["level"] = 1;
				baseRef = refString;
			}
		}
	}
}
buildMPChallengeInfo()
{
	level.challengeInfoMP = [];
	
	for ( i = 1; i <= level.numChallengeTiersMP; i++ )
	{
		tableName = "mp/challengetable_tier"+i+".csv";
		baseRef = "";
		
		for( idx = 1; isdefined( tableLookup( tableName, 0, idx, 0 ) ) && tableLookup( tableName, 0, idx, 0 ) != ""; idx++ )
		{
			stat_num = tableLookup( tableName, 0, idx, 2 );
			refString = tableLookup( tableName, 0, idx, 7 );
			
			level.challengeInfoMP[refString] = [];
			level.challengeInfoMP[refString]["tier"] = i;
			level.challengeInfoMP[refString]["stateid"] = int( tableLookup( tableName, 0, idx, 2 ) );
			level.challengeInfoMP[refString]["statid"] = int( tableLookup( tableName, 0, idx, 3 ) );
			level.challengeInfoMP[refString]["maxval"] = int( tableLookup( tableName, 0, idx, 4 ) );
			level.challengeInfoMP[refString]["minval"] = int( tableLookup( tableName, 0, idx, 5 ) );
			level.challengeInfoMP[refString]["fullname"] = tableLookup( tableName, 0, idx, 7 );
			level.challengeInfoMP[refString]["name"] = tableLookupIString( tableName, 0, idx, 8 );
			level.challengeInfoMP[refString]["desc"] = tableLookupIString( tableName, 0, idx, 9 );
			level.challengeInfoMP[refString]["reward"] = int( tableLookup( tableName, 0, idx, 10 ) );
			level.challengeInfoMP[refString]["camo"] = tableLookup( tableName, 0, idx, 12 );
			level.challengeInfoMP[refString]["attachment"] = tableLookup( tableName, 0, idx, 13 );
			level.challengeInfoMP[refString]["group"] = tableLookup( tableName, 0, idx, 14 );
			
		}
	}
}
processChallengeBit( baseName, whichbit, levelEnd )
{
	if ( !mayProcessChallenges() )
		return 0;
	if( !isDefined( levelEnd ) )
	{
		levelEnd = false;
	}
		
	refString = baseName;
	missionStatus = self getChallengeStatus( baseName );
	if ( !missionStatus || missionStatus == 255 )
		return 0;
	self setStatBit( level.challengeInfo[refString]["statid"], whichbit, 1 );
	progress = self getStat( level.challengeInfo[refString]["statid"] );
	if ( progress >= level.challengeInfo[refString]["maxval"] )
	{
		missionStatus = 255;
		self thread challengeNotify( level.challengeInfo[refString]["name"], levelEnd );
		self setStat( level.challengeInfo[refString]["stateid"], missionStatus );
		self giveRankXP( "challenge", level.challengeInfo[refString]["reward"] );
		
		return 1;
	}
	
	return 0;
}
processChallenge( baseName, progressInc, levelEnd )
{
	if ( !mayProcessChallenges() )
		return 0; 
		
	if(	!isDefined( levelEnd ) )
	{
		levelEnd = false;
	}
		
	numLevels = getChallengeLevels( baseName );
	
	if ( numLevels > 1 )
		missionStatus = self getChallengeStatus( (baseName + "1") );
	else
		missionStatus = self getChallengeStatus( baseName );
	if ( !isDefined( progressInc ) )
		progressInc = 1;
	
	
	
	if ( !missionStatus || missionStatus == 255 )
		return 0; 
		
	assertex( missionStatus <= numLevels, "Mini challenge levels higher than max: " + missionStatus + " vs. " + numLevels );
	
	if ( numLevels > 1 )
		refString = baseName + missionStatus;
	else
		refString = baseName;
	progress = self getStat( level.challengeInfo[refString]["statid"] );
	progress += progressInc;
	
	self setStat( level.challengeInfo[refString]["statid"], progress );
	if ( progress >= level.challengeInfo[refString]["maxval"] )
	{
		if( false == levelEnd )
		{
			self thread challengeNotify( level.challengeInfo[refString]["name"] );
		}
		
		
		
		
		if ( missionStatus == numLevels )
			missionStatus = 255;
		else
			missionStatus += 1;
		if ( numLevels > 1 )
			self.challengeData[baseName + "1"] = missionStatus;
		else
			self.challengeData[baseName] = missionStatus;
		
		self setStat( level.challengeInfo[refString]["statid"], level.challengeInfo[refString]["maxval"] );
		self setStat( level.challengeInfo[refString]["stateid"], missionStatus );
		
		self giveRankXP( "challenge", level.challengeInfo[refString]["reward"], levelEnd );
		
		return 1; 
	}
	
	return 0; 
}
resetChallengeProgress( baseName, progress )
{
	if ( !mayProcessChallenges() )
		return;
		
	numLevels = getChallengeLevels( baseName );
	
	if ( numLevels > 1 )
		missionStatus = self getChallengeStatus( (baseName + "1") );
	else
		missionStatus = self getChallengeStatus( baseName );
	if ( !isDefined( progress ) )
		progress = 0;
	
	
	
	if ( !missionStatus || missionStatus == 255 )
		return;
		
	assertex( missionStatus <= numLevels, "Mini challenge levels higher than max: " + missionStatus + " vs. " + numLevels );
	
	if ( numLevels > 1 )
		refString = baseName + missionStatus;
	else
		refString = baseName;
	prevprogress = self getStat( level.challengeInfo[refString]["statid"] );
	
	if ( prevprogress < level.challengeInfo[refString]["maxval"] )
	{
		self setStat( level.challengeInfo[refString]["statid"], progress );
	}
}
giveRankXP( type, value, levelEnd )
{
	self endon("disconnect");
	if(	!isDefined( levelEnd ) )
	{
		levelEnd = false;
	}	
	
	value = int( value * level.xpScale );
	switch( type )
	{
		case "challenge":
			self.summary_challenge += value;
			self.summary_xp += value;
	}
		
	self incRankXP( value );
	if ( level.rankedMatch && updateRank() && false == levelEnd )
		self thread updateRankAnnounceHUD();
	
	self syncXPStat();
}
updateRankAnnounceHUD()
{
	self endon("disconnect");
	self notify("update_rank");
	self endon("update_rank");
	
	self notify("reset_outcome");
	newRankName = self getRankInfoFull( self.rank );
	
	notifyData = spawnStruct();
	notifyData.titleText = &"RANK_PROMOTED";
	notifyData.iconName = self getRankInfoIcon( self.rank, self.prestige );
	notifyData.sound = "mp_level_up";
	notifyData.duration = 4.0;
	
	rank_char = level.rankTable[self.rank][1];
	subRank = int(rank_char[rank_char.size-1]);
	
	if ( subRank == 2 )
	{
		notifyData.textLabel = newRankName;
		notifyData.notifyText = &"RANK_ROMANI";
		notifyData.textIsString = true;
	}
	else if ( subRank == 3 )
	{
		notifyData.textLabel = newRankName;
		notifyData.notifyText = &"RANK_ROMANII";
		notifyData.textIsString = true;
	}
	else if ( subRank == 4 )
	{
		notifyData.textLabel = newRankName;
		notifyData.notifyText = &"RANK_ROMANIII";
		notifyData.textIsString = true;
	}
	else
	{
		notifyData.notifyText = newRankName;
	}
	self thread maps\_hud_message::notifyMessage( notifyData );
}
updateRank()
{
	newRankId = self getRank();
	if ( newRankId == self.rank )
		return false;
	oldRank = self.rank;
	rankId = self.rank;
	self.rank = newRankId;
	while ( rankId <= newRankId )
	{	
		self statSet( "rank", rankId );
		self statSet( "minxp", int(level.rankTable[rankId][2]) );
		self statSet( "maxxp", int(level.rankTable[rankId][7]) );
	
		
		self setStat( 252, rankId );
	
		
		unlockedWeapon = self getRankInfoUnlockWeapon( rankId );	
		if ( isDefined( unlockedWeapon ) && unlockedWeapon != "" )
			unlockWeapon( unlockedWeapon );
	
		
		unlockedPerk = self getRankInfoUnlockPerk( rankId );	
		if ( isDefined( unlockedPerk ) && unlockedPerk != "" )
			unlockPerk( unlockedPerk );
			
		
		unlockedChallenge = self getRankInfoUnlockChallenge( rankId );
		if ( isDefined( unlockedChallenge ) && unlockedChallenge != "" )
			unlockChallenge( unlockedChallenge );
		
		unlockedAttachment = self getRankInfoUnlockAttachment( rankId );	
		if ( isDefined( unlockedAttachment ) && unlockedAttachment != "" )
			unlockAttachment( unlockedAttachment );	
		
		unlockedCamo = self getRankInfoUnlockCamo( rankId );	
		if ( isDefined( unlockedCamo ) && unlockedCamo != "" )
			unlockCamo( unlockedCamo );
		unlockedFeature = self getRankInfoUnlockFeature( rankId );	
		if ( isDefined( unlockedFeature ) && unlockedFeature != "" )
			unlockFeature( unlockedFeature );
		rankId++;
	}
	
	self setRank( newRankId );
	
	return true;
}
getPrestigeLevel()
{
	return self statGet( "plevel" );
}
getRank()
{	
	rankXp = self.rankxp;
	rankId = self.rank;
	if ( rankXp < (getRankInfoMinXP( rankId ) + getRankInfoXPAmt( rankId )) )
		return rankId;
	else
		return self getRankForXp( rankXp );
}
getRankXP()
{
	return self.rankxp;
}
getRankForXp( xpVal )
{
	rankId = 0;
	rankName = level.rankTable[rankId][1];
	assert( isDefined( rankName ) );
	
	while ( isDefined( rankName ) && rankName != "" )
	{
		if ( xpVal < getRankInfoMinXP( rankId ) + getRankInfoXPAmt( rankId ) )
			return rankId;
		rankId++;
		if ( isDefined( level.rankTable[rankId] ) )
			rankName = level.rankTable[rankId][1];
		else
			rankName = undefined;
	}
	
	rankId--;
	return rankId;
}
getRankInfoMinXP( rankId )
{
	return int(level.rankTable[rankId][2]);
}
getRankInfoXPAmt( rankId )
{
	return int(level.rankTable[rankId][3]);
}
getRankInfoMaxXp( rankId )
{
	return int(level.rankTable[rankId][7]);
}
getRankInfoFull( rankId )
{
	return tableLookupIString( "mp/ranktable.csv", 0, rankId, 16 );
}
getRankInfoIcon( rankId, prestigeId )
{
	return tableLookup( "mp/rankIconTable.csv", 0, rankId, prestigeId+1 );
}
getRankInfoUnlockWeapon( rankId )
{
	return tableLookup( "mp/ranktable.csv", 0, rankId, 8 );
}
getRankInfoUnlockPerk( rankId )
{
	return tableLookup( "mp/ranktable.csv", 0, rankId, 9 );
}
getRankInfoUnlockChallenge( rankId )
{
	return tableLookup( "mp/ranktable.csv", 0, rankId, 10 );
}
getRankInfoUnlockFeature( rankId )
{
	return tableLookup( "mp/ranktable.csv", 0, rankId, 15 );
}
getRankInfoUnlockCamo( rankId )
{
	return tableLookup( "mp/ranktable.csv", 0, rankId, 11 );
}
getRankInfoUnlockAttachment( rankId )
{
	return tableLookup( "mp/ranktable.csv", 0, rankId, 12 );
}
unlockWeapon( refString )
{
	assert( isDefined( refString ) && refString != "" );
	
	
	Ref_Tok = strTok( refString, " " );
	assertex( Ref_Tok.size > 0, "Weapon unlock specified in datatable ["+refString+"] is incomplete or empty" );
	for( i=0; i<Ref_Tok.size; i++ )
		unlockWeaponSingular( Ref_Tok[i] );
}
unlockWeaponSingular( refString )
{
	stat = int( tableLookup( "mp/statstable.csv", 4, refString, 1 ) );
	
	assertEx( stat > 0, "statsTable refstring " + refString + " has invalid stat number: " + stat );
	
	statVal = self getStat( stat );
	if ( statVal & 1 )
		return;
	self setStat( stat, (statVal | 65537) );
	self setStat( stat, 65537 );	
}
unlockPerk( refString )
{
	assert( isDefined( refString ) && refString != "" );
	
	Ref_Tok = strTok( refString, ";" );
	assertex( Ref_Tok.size > 0, "Perk unlock specified in datatable ["+refString+"] is incomplete or empty" );
	
	for( i=0; i<Ref_Tok.size; i++ )
		unlockPerkSingular( Ref_Tok[i] );
}
unlockPerkSingular( refString )
{
	assert( isDefined( refString ) && refString != "" );
	stat = int( tableLookup( "mp/statstable.csv", 4, refString, 1 ) );
	
	if( self getStat( stat ) > 0 )
		return;
	self setStat( stat, 2 );	
}
unlockCamo( refString )
{
	assert( isDefined( refString ) && refString != "" );
	
	Ref_Tok = strTok( refString, ";" );
	assertex( Ref_Tok.size > 0, "Camo unlock specified in datatable ["+refString+"] is incomplete or empty" );
	
	for( i=0; i<Ref_Tok.size; i++ )
		unlockCamoSingular( Ref_Tok[i] );
}
unlockCamoSingular( refString )
{
	
	Tok = strTok( refString, " " );
	assertex( Tok.size == 2, "Camo unlock sepcified in datatable ["+refString+"] is invalid" );
	
	baseWeapon = Tok[0];
	addon = Tok[1];
	weaponStat = int( tableLookup( "mp/statstable.csv", 4, baseWeapon, 1 ) );
	addonMask = int( tableLookup( "mp/attachmenttable.csv", 4, addon, 10 ) );
	
	if ( self getStat( weaponStat ) & addonMask )
		return;
	
	
	setstatto = ( self getStat( weaponStat ) | addonMask ) | (addonMask<<16) | (1<<16);
	self setStat( weaponStat, setstatto );
}
unlockAttachment( refString )
{
	assert( isDefined( refString ) && refString != "" );
	
	Ref_Tok = strTok( refString, ";" );
	assertex( Ref_Tok.size > 0, "Attachment unlock specified in datatable ["+refString+"] is incomplete or empty" );
	
	for( i=0; i<Ref_Tok.size; i++ )
		unlockAttachmentSingular( Ref_Tok[i] );
}
unlockAttachmentSingular( refString )
{
	Tok = strTok( refString, " " );
	assertex( Tok.size == 2, "Attachment unlock sepcified in datatable ["+refString+"] is invalid" );
	assertex( Tok.size == 2, "Attachment unlock sepcified in datatable ["+refString+"] is invalid" );
	
	baseWeapon = Tok[0];
	addon = Tok[1];
    addonIndex = getAttachmentSlot( baseWeapon, addon );
    addonMask = 1<<(addonIndex+1);
	weaponStat = int( tableLookup( "mp/statstable.csv", 4, baseWeapon, 1 ) );
	
	if ( self getStat( weaponStat ) & addonMask )
		return;
	
	
	setstatto = ( self getStat( weaponStat ) | addonMask ) | (addonMask<<16) | (1<<16);
	self setStat( weaponStat, setstatto );
}
getAttachmentSlot( baseWeapon, attachmentName )
{
	weaponIndex = int( tableLookup( "mp/statstable.csv", 4, baseWeapon, 0 ) );
	attachment_array_string = level.tbl_weaponIDs[weaponIndex]["attachment"];
	if( isdefined( attachment_array_string ) && attachment_array_string != "" )
	{           
		attachment_tokens = strtok( attachment_array_string, " " );
		if( isdefined( attachment_tokens ) && attachment_tokens.size != 0 )
		{
			
			for( k = 0; k < attachment_tokens.size; k++ )
			{
				if ( attachment_tokens[k] == attachmentName )
					return k;
			}
		}
		assertex( 0, "Could not find attachment " + attachmentName + " in weapon " + baseWeapon ); 
	}
	return 0;
}
unlockChallenge( refString )
{
	assert( isDefined( refString ) && refString != "" );
	
	Ref_Tok = strTok( refString, ";" );
	assertex( Ref_Tok.size > 0, "Camo unlock specified in datatable ["+refString+"] is incomplete or empty" );
	
	for( i=0; i<Ref_Tok.size; i++ )
	{
		if ( getSubStr( Ref_Tok[i], 0, 3 ) == "ch_" )
			unlockChallengeSingular( Ref_Tok[i] );
		else
			unlockChallengeGroup( Ref_Tok[i] );
	}
}
unlockChallengeSingular( refString )
{
	assertEx( isDefined( level.challengeInfoMP[refString] ), "Challenge unlock "+refString+" does not exist." );
	tableName = "mp/challengetable_tier" + level.challengeInfoMP[refString]["tier"] + ".csv";
	
	if ( self getStat( level.challengeInfoMP[refString]["stateid"] ) )
		return;
	self setStat( level.challengeInfoMP[refString]["stateid"], 1 );
	
	
	self setStat( 269 + level.challengeInfoMP[refString]["tier"], 2 );
}
unlockChallengeGroup( refString )
{
	tokens = strTok( refString, "_" );
	assertex( tokens.size > 0, "Challenge unlock specified in datatable ["+refString+"] is incomplete or empty" );
	
	assert( tokens[0] == "tier" );
	
	tierId = int( tokens[1] );
	assertEx( tierId > 0 && tierId <= level.numChallengeTiersMP, "invalid tier ID " + tierId );
	groupId = "";
	if ( tokens.size > 2 )
		groupId = tokens[2];
	challengeArray = getArrayKeys( level.challengeInfoMP );
	
	unlocked = false;
	for ( index = 0; index < challengeArray.size; index++ )
	{
		challenge = level.challengeInfoMP[challengeArray[index]];
		
		if ( challenge["tier"] != tierId )
			continue;
			
		if ( challenge["group"] != groupId )
			continue;
			
		if ( self getStat( challenge["stateid"] ) )
			continue;
		self setStat( challenge["stateid"], 1 );
		
		
		self setStat( 269 + challenge["tier"], 2 );
	}
}
unlockFeature( refString )
{
	assert( isDefined( refString ) && refString != "" );
	
	Ref_Tok = strTok( refString, ";" );
	assertex( Ref_Tok.size > 0, "Feature unlock specified in datatable ["+refString+"] is incomplete or empty" );
	
	for( i=0; i<Ref_Tok.size; i++ )
		unlockFeatureSingular( Ref_Tok[i] );
}
unlockFeatureSingular( refString )
{
	assert( isDefined( refString ) && refString != "" );
	stat = int( tableLookup( "mp/statstable.csv", 4, refString, 1 ) );
	
	if( self getStat( stat ) > 0 )
		return;
	if ( refString == "feature_cac" )
		self setStat( 260, 1 );
	self setStat( stat, 2 ); 
}
updateMPChallenges()
{
	self.challengeMPData = [];
	for ( i = 1; i <= level.numChallengeTiersMP; i++ )
	{
		tableName = "mp/challengetable_tier"+i+".csv";
		idx = 1;
		
		for( idx = 1; isdefined( tableLookup( tableName, 0, idx, 0 ) ) && tableLookup( tableName, 0, idx, 0 ) != ""; idx++ )
		{
			stat_num = tableLookup( tableName, 0, idx, 2 );
			if( isdefined( stat_num ) && stat_num != "" )
			{
				statVal = self getStat( int( stat_num ) );
				
				refString = tableLookup( tableName, 0, idx, 7 );
				if ( statVal )
					self.challengeMPData[refString] = statVal;
			}
		}
	}
}
incRankXP( amount )
{
	if ( !mayProcessChallenges() )
		return;
	
	xp = self getRankXP();
	newXp = (xp + amount);
	if ( self.rank == level.maxRank && newXp >= getRankInfoMaxXP( level.maxRank ) )
		newXp = getRankInfoMaxXP( level.maxRank );
	self.rankxp = newXp;
}
syncXPStat()
{
	xp = self getRankXP();
	
	self statSet( "rankxp", xp );
}
ch_goooal()
{
	self processChallenge( "ch_goooal_1" );
	wait( 0.5 );
	self processChallenge( "ch_goooal_1", -1 );
}
ch_bbq()
{
	self processChallenge( "ch_bbq_1" );
	wait( 4.0 );
	self processChallenge( "ch_bbq_1", -1 );
}
ch_hothands( weapon )		
{
	if( !IsDefined(self.hothandscount) )
	{
		self.hothandscount = 0;
		self.hothandsweapon = weapon;
		self.hothandsweaponswitched = false;
	}
	if( self.hothandsweapon != weapon )
	{
		self.hothandsweaponswitched = true;
	}
	self.hothandsweapon = weapon;
	self.hothandscount++;
	if( self.hothandscount > 4 && self.hothandsweaponswitched )
	{
		self processChallenge( "ch_hothands_1" );
	}
	wait( 11.0 );	
	self.hothandscount--;
	if( self.hothandscount == 0 )
	{
		self.hothandscount = undefined;
	}
}
ch_wagofthefinger()	
{
	if( !IsDefined(level.lastwagplayer) )
	{
		level.wagofthefinger = 0;
		level.lastwagplayer = self;
	}
	level.wagofthefinger++;
	if( level.wagofthefinger > 1 && level.lastwagplayer != self )
	{
		self processChallenge( "ch_wagofthefinger_1" );
		level.lastwagplayer processChallenge( "ch_wagofthefinger_1" );
	}
	level.lastwagplayer = self;
	wait 0.5;
	level.wagofthefinger--;
	if( level.wagofthefinger == 0 )
	{
		level.lastwagplayer = undefined;
	}
}
ch_doubleheader()	
{
	if( !IsDefined(level.lastdhplayer) )
	{
		level.doubleheader = 0;
		level.lastdhplayer = self;
	}
	level.doubleheader++;
	if( level.doubleheader > 1 && level.lastdhplayer != self )
	{
		self processChallenge( "ch_doubleheader_1" );
		level.lastdhplayer processChallenge( "ch_doubleheader_1" );
	}
	level.lastdhplayer = self;
	wait 0.5;
	level.doubleheader--;
	if( level.doubleheader == 0 )
	{
		level.lastdhplayer = undefined;
	}
}
ch_brassCollector()
{
	self waittill( "reload_start" );
	self.ch_brassCollector = 0;
}
ch_assists( player )
{
	if ( !isDefined( player ) || !isPlayer( player ) )
	{
		return;
	}
	player processChallenge( "ch_assist_1" );
}
ch_kills( victim )
{
	if ( !isDefined( victim.attacker ) || !isPlayer( victim.attacker ) || victim.team == "allies" )
		return;
	
	player = victim.attacker;
	if( player maps\_laststand::player_is_in_laststand() )
	{
		player processChallenge( "ch_luckypunk_1" );
	}
	weap_class = weaponClass( victim.damageWeapon );
	
	
	if( victim.damageWeapon == "molotov" )
	{
		player processChallenge( "ch_molotov_1" );
	}
	if( victim.damagemod == "MOD_MELEE" || victim.damagemod == "MOD_BAYONET" )
	{
		player processChallenge( "ch_knife_1" );
		player thread ch_wagofthefinger();
	}
	else if( victim.damagemod == "MOD_PISTOL_BULLET" || victim.damagemod == "MOD_RIFLE_BULLET" )
	{
		if( victim.damagelocation == "head" || victim.damagelocation == "helmet" )
		{
			if ( !isdefined( player.hatTrickChallengeHeadShotCount ) )
			{
				player.hatTrickChallengeHeadShotCount = 0;
			}
			player.hatTrickChallengeHeadShotCount++;
			if ( player.hatTrickChallengeHeadShotCount >= 3 )
			{
				player.hatTrickChallengeHeadShotCount = 0;
				if ( !isdefined( player.hatTrickChallengeHatTrickCount ) )
				{
					player.hatTrickChallengeHatTrickCount = 0;
				}
				player.hatTrickChallengeHatTrickCount++;
				if( player.hatTrickChallengeHatTrickCount >= 3 )
				{
					player processChallenge( "ch_headshot_1" );
				}
			}
			player thread ch_hothands( victim.damageWeapon );
			player thread ch_doubleheader();
		}
		else
		{
			player.hatTrickChallenge = 0;
		}
		if( weap_class == "pistol" )
		{
			player processChallenge( "ch_pistol_1" );
		}
		else if( weap_class == "smg" )
		{
			player processChallenge( "ch_submachinegun_1" );
		}
		else if( weap_class == "rifle" )
		{
			player processChallenge( "ch_sniper_1" );
		}
		else if( weap_class == "mg" )
		{
			player processChallenge( "ch_machinegun_1" );
		}
		else if( weap_class == "spread" )
		{
			player processChallenge( "ch_shotgun_1" );
		}
	}
	else if( victim.damagemod == "MOD_BURNED" )
	{
		if( weap_class == "gas" )
		{
			player processChallenge( "ch_flame_1" );
			player thread ch_bbq();
		}
	}
	else if( victim.damagemod == "MOD_CRUSH" )
	{
		player processChallenge( "ch_roadkill_1" );
	}
	else if( victim.damagemod == "MOD_GRENADE" || victim.damagemod == "MOD_GRENADE_SPLASH" )
	{
		player processChallenge( "ch_grenade_1" );
		player thread ch_goooal();
	}
	
	if( isDefined( victim.throwbackgrenadekilledOriginalOwner ) )
	{
		player processChallenge( "ch_hotpotato_1" );
		if( IsPlayer( victim.throwbackgrenadekilledOriginalOwner ) )
		{
			player processChallenge( "ch_fleaflicker_1" );
			victim.throwbackgrenadekilledOriginalOwner processChallenge( "ch_fleaflicker_1" );
		}
	}
	if( isDefined( victim.ai_supplement_type ) )
	{
		if( victim.ai_supplement_type == "banzai" || victim.ai_supplement_type == "grenadesuicide" )
		{
			player processChallenge( "ch_banzai_1" );
		}
	}
	if( isDefined( victim.banzai ) && victim.banzai )
	{
		player processChallenge( "ch_banzai_1" );
	}
	if( isDefined(victim.script_noteworthy) && victim.script_noteworthy == "no_climb" )
	{
		player processChallenge( "ch_treesniper_1" );
	}
	else if( isDefined( victim.animname ) && victim.animname == "tree_guy" )
	{
		player processChallenge( "ch_treesniper_1" );
	}
	
	if( IsDefined( victim.helmetPopper ) && player != victim.helmetPopper )
	{
		player processChallenge( "ch_tipofthehat_1" );
		victim.helmetPopper processChallenge( "ch_tipofthehat_1" );
	}
	player processKillStreakChallenge();
}
processKillStreakChallenge()
{
	if( !IsDefined( self.challengeKillStreak ) )
	{
		self.challengeKillStreak = 0;
	}
	self.challengeKillStreak++;
	if( self.challengeKillStreak == 30 )
	{
		self processChallenge( "ch_diehard_1" );
	}
	else if( self.challengeKillStreak == 50 )
	{
		self processChallenge( "ch_bulletproof_1" );
	}
	else if( self.challengeKillStreak == 75 )
	{
		self processChallenge( "ch_goldengod_1" );
	}
}
ch_revives( player )
{
}
ch_checkpointLoaded( player )	
{
	ch_reset_alive_challenges( player );
	if ( !isdefined( level.playerDeaths ) )
	{
		level.playerDeaths = 0;
	}
	level.playerDeaths++;
}
ch_dies( player )	
{
	ch_reset_alive_challenges( player );
	if ( !isdefined( level.playerDeaths ) )
	{
		level.playerDeaths = 0;
	}
	level.playerDeaths++;
}
ch_reset_alive_challenges( player )	
{
	player.challengeKillStreak = 0;
	player resetChallengeProgress( "ch_goooal_1" );		
	player resetChallengeProgress( "ch_brasscollector_1" );	
	player resetChallengeProgress( "ch_bbq_1" );	
}
ch_multiplierChanged( player )
{
	if( player getScoreMultiplier() == 10 )
	{
		player processChallenge( "ch_multiplier_1", player getScoreMultiplier() );
	}
}
ch_gib( victim )
{
	
	if ( !isDefined( victim.attacker ) || !isPlayer( victim.attacker ) )
		return;
	
	player = victim.attacker;
	player processChallenge( "ch_gib_1" );
}
ch_levelEnd( level_index )
{	
	if( false == level.rankedMatch )
	{
		return;
	}
	
	players = get_players();	
	for ( i = 0 ; i < players.size ; i++ )
	{
		players[i] thread playerLevelEndChallengeProcess();
	}
}
playerLevelEndChallengeProcess()
{
	self endon("disconnect");
	
	oldRank = self.rank;
	
	totalChallengesUnlock = 0;
		
	players = get_players();	
	if( GetDvar( #"onlinegame" ) == "1" && arcadeMode() && players.size == 4 )
	{
		highest_score = players[0].score;
		highest = 0;
			
		for ( i = 1 ; i < players.size ; i++ )
		{
			if ( players[i].score > highest_score )
			{
				highest = i;
				highest_score = players[i].score;
			}
		}
		
		if( highest == self GetEntityNumber() )
		{
			totalChallengesUnlock += self processChallenge( "ch_tipeofthehat_1", 1, true );
		}
	}
		
	levelChallengeName = "ch_"+level.script+"_1";
	if ( isDefined( level.challengeInfo[levelChallengeName] ) && arcadeMode() && isDefined( self.score ) )
	{
		self resetChallengeProgress( levelChallengeName );
		totalChallengesUnlock += self processChallenge( levelChallengeName, self.score, true );
	}
	if ( !isdefined( level.playerDeaths ) || level.playerDeaths == 0 )
	{
		totalChallengesUnlock += self processChallenge( "ch_purpleheart_1", 1, true );
	}
	if ( level.script != "see2" && (!isdefined( self.ch_brassCollector ) || self.ch_brassCollector != 0) )
	{
		totalChallengesUnlock += self processChallenge( "ch_brasscollector_1", 1, true );
	}
	
	
	totalChallengesUnlock += self processTourChallenges( true );
	
	if( 0 < totalChallengesUnlock )
	{
		notifyData = spawnStruct();
		
		if( 1 == totalChallengesUnlock )
		{
			notifyData.titleText = &"CHALLENGE_COOP_COMPLETED";
		}
		else
		{
			notifyData.titleText = &"CHALLENGE_MULTIPLE_COOP_COMPLETED";
		}
					
		notifyData.notifyText = &"CHALLENGE_MULTIPLE_COOP_COMPLETED_DETAILS";
		notifyData.sound = "mp_challenge_complete";
		self thread maps\_hud_message::notifyMessage( notifyData );
					
		if ( oldRank < self.rank )
		{
			self updateRankAnnounceHUD();
		}		
	}
}
processTourChallenges( levelEnd )
{
	if( !isDefined( levelEnd ) )
	{
		levelEnd = false;
	}
	pacificTour = false;
	europeanTour = false;
	
	whichbit = 0;
	challengeUnlocked = 0;
	if( pacificTour )
	{
		challengeUnlocked = processChallengeBit( "ch_pacific_tour_1", whichbit, levelEnd );
	}
	else if( europeanTour )
	{
		challengeUnlocked = processChallengeBit( "ch_european_tour_1", whichbit, levelEnd );
	}
	
	return challengeUnlocked; 
}
doMissionCallback( callback, data )
{
	if ( mayProcessChallenges() )
	{	
		if ( GetDvarInt( #"disable_challenges" ) > 0 )
			return;
		
		if ( !isDefined( level.missionCallbacks[callback] ) )
			return;
	
		if ( isDefined( data ) ) 
		{
			for ( i = 0; i < level.missionCallbacks[callback].size; i++ )
				thread [[level.missionCallbacks[callback][i]]]( data );
		}
		else 
		{
			for ( i = 0; i < level.missionCallbacks[callback].size; i++ )
				thread [[level.missionCallbacks[callback][i]]]();
		}
	}
	if ( mayGenerateAfterActionReport() )
	{			
		
		
		
		players = get_players();
		for ( i = 0; i < players.size; i++ )
		{
			players[i] updateMatchSummary( callback );
		}
	}	
}
statGet( dataName )
{
	if ( !level.onlineGame )
		return 0;
	
	return self getStat( int(tableLookup( "mp/playerStatsTable.csv", 1, dataName, 0 )) );
}
statSet( dataName, value )
{
	if ( !mayProcessChallenges() )
		return;
	
	self setStat( int(tableLookup( "mp/playerStatsTable.csv", 1, dataName, 0 )), value );	
}
cac_init()
{
	level.tbl_weaponIDs = [];
	for( i=0; i<150; i++ )
	{
		reference_s = tableLookup( "mp/statsTable.csv", 0, i, 4 );
		if( reference_s != "" )
		{ 
			level.tbl_weaponIDs[i]["reference"] = reference_s;
			level.tbl_weaponIDs[i]["group"] = tablelookup( "mp/statstable.csv", 0, i, 2 );
			level.tbl_weaponIDs[i]["count"] = int( tablelookup( "mp/statstable.csv", 0, i, 5 ) );
			level.tbl_weaponIDs[i]["attachment"] = tablelookup( "mp/statstable.csv", 0, i, 8 );	
		}
		else
			continue;
	}
}
class_init()
{
	max_weapon_num = 149;
	for( i = 0; i < max_weapon_num; i++ )
	{
		if( !isdefined( level.tbl_weaponIDs[i] ) || level.tbl_weaponIDs[i]["group"] == "" )
			continue;
		if( !isdefined( level.tbl_weaponIDs[i] ) || level.tbl_weaponIDs[i]["reference"] == "" )
			continue;		
	
		
		weapon_type = level.tbl_weaponIDs[i]["group"]; 
		weapon = level.tbl_weaponIDs[i]["reference"]; 
		attachment = level.tbl_weaponIDs[i]["attachment"]; 
	}
}  
