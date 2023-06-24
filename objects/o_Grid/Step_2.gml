/// @description Insert description here
// You can write your code in this editor

if (food > food_cap)
{
	food = food_cap;
}

if (wood > wood_cap)
{
	wood = wood_cap;
}

if (stone > stone_cap)
{
	stone = stone_cap;
}

if (iron > iron_cap)
{
	iron = iron_cap;
}

if (turn != prev_turn) && (continue_ == true)
{
	show_debug_message("Process turn");
	
	// if there is less food than pop set pop_growth to zero if it isnt alrady below it
	if (food < pop)
	{
		if (pop_growth > 0)
		{
			pop_growth = 0;
		}
		
		pop_growth--;
	}
	
	// subtract a food for each pop 
	food -= pop;
	
	// if food goes below zero set it to zero
	if (food < 0)
	{
		food = 0;	
	}
	
	// if there is more food than pop, and pop growth is less than 0 set it to zero
	if (food > pop && pop_growth < 0)
	{
		pop_growth = 0;	
	}
	
	// if food is greater than pop times 2 increment pop_growth
	if (food > pop * 2)
	{
		pop_growth++;	
	}
	
	// if pop growth is larger or equal to 3, the player has had food two times greater than pop for 3 turns, increase pop
	if (pop_growth >= 3 && pop_cap > pop)
	{
		show_debug_message("pop Growth")
		pop++;
		pop_growth = 0;
	}

	// if pop_growth is less than -3, the player has had insufficent food for pop for 3 turns, decrease pop
	if (pop_growth <= -3 && pop > 0)
	{
		pop--;
		pop_growth = 0;
	}
	
	// Process turn
	for (var mX = 0; mX < MAP_W; mX++)
	{
		for (var mY = 0; mY < MAP_H; mY++)
		{
			var tileData = global.map[# mX, mY];
			var tileZ = tileData[TILE.Z];
			var tileTerrain = tileData[TILE.TERRAIN];
				
			var buildData = global.buildings[# mX, mY];
			var buildBuidlings = buildData[BUILD.BUILDING];
			var buildLevel = buildData[BUILD.LEVEL];
				
			var workerData = global.workers[# mX, mY];
			var workers = workerData[0];
			
			if (townhallTurn == -1)
			{
				if (buildBuidlings == BUILDING.TOWNHALL && buildLevel >= 2)
				{
					show_debug_message("townhall placed")
					townhallTurn = turn;
				}
			}
			else if ((turn - townhallTurn) >= turn_til_Draft)
			{
					draft = true;
					turn_til_Draft = 9;
					townhallTurn = turn;
			}
			
			switch (buildBuidlings)
			{
				case BUILDING.FORREST:
					wood += 2 * workers;

					if (buildLevel < 2)
					{
						buildData[@ BUILD.LEVEL] += 1; 
					}
					
					if (workers > 0)
					{
						buildData[@ BUILD.LEVEL] -= workers; 
						
						var buildLevel = buildData[BUILD.LEVEL];
						
						if (buildLevel <= 0)
						{
							buildData[@ BUILD.BUILDING] = BUILDING.NOTHING;
							buildData[@ BUILD.LEVEL] = 0;
						}
					}

				break;
				
				case BUILDING.QUARRY:
					stone += 4 * workers;
					
					var ironOdds = 6;
					
					repeat (workers)
					{
						for (var wmX = mX - 1; wmX < mX + 2; wmX++)
						{
							for (var wmY = mY - 1; wmY < mY + 2; wmY++)
							{
								var buildAdjData = global.buildings[# wmX, wmY];
								var buildAdjBuidlings = buildAdjData[BUILD.BUILDING];
								var buildAdjLevel = buildAdjData[BUILD.LEVEL]
								
								var workerAdjData = global.workers[# wmX, wmY];
								var workers = workerAdjData[@ 0];
								
								if (buildAdjBuidlings == BUILDING.MINE && buildAdjLevel >= 2)
								{
									ironOdds = 6 - (buildAdjLevel-1) - workers;	
								}
							}
						}
						
						if (irandom(ironOdds) == ironOdds)
						{
							iron++;	
						}
					}
					
				break;
				
				case BUILDING.WINDMILL:
				
				/*
					Windmils when worked work all adjacent fields for 0.25% of their yeild
					All adjacent tiles need to be check for level 2 fields
					If a feild is present the terrain has to be check for fertile 
					The Field then has to be taken down to level 0 or -1 if the tile has not yet been level up by the end of the turn
					Then calculate the food produced taking fertile terrain into account
				*/
				
				var foodGain = 0;
				
				if (workers > 0) {
					for (var wmX = mX - 1; wmX < mX + 2; wmX++)
					{
						for (var wmY = mY - 1; wmY < mY + 2; wmY++)
						{
							var buildAdjData = global.buildings[# wmX, wmY];
							var buildAdjBuidlings = buildAdjData[BUILD.BUILDING];
							var buildAdjLevel = buildAdjData[BUILD.LEVEL];
							
							var tileAdjData = global.map[# wmX, wmY];
							var tileAdjTerrain = tileAdjData[TILE.TERRAIN];
						
							if (buildAdjBuidlings == BUILDING.FIELD && buildAdjLevel == 2)
							{
								var fertile = false;
								
								if (tileAdjTerrain == TERRAIN.FERTILE)
								{
									fertile = true;
								}
								
								if (wmX > mX || wmY > mY) {
									buildAdjData[@ BUILD.LEVEL] = -1; 
								}
								else
								{
									buildAdjData[@ BUILD.LEVEL] = 0; 
								}
								
								if (wmX == mX-1 && wmY == mY+1)
								{
									buildAdjData[@ BUILD.LEVEL] = 0; 
								}
								
								foodGain += ((4 + fertile) * (0.5*(buildLevel-1))) * workers;
							}
						}
					}
					
					show_debug_message("foodGain")
					show_debug_message(foodGain);
					food += round(foodGain);
				}
				
				
				
				
				break;
				
				case BUILDING.FIELD:
					var foodGain = 4 * workers;
					show_debug_message(foodGain);
					
					food += foodGain;
					
					if (buildLevel < 2)
					{
						buildData[@ BUILD.LEVEL] += 1; 
					}
					
					if (workers > 0)
					{
						buildData[@ BUILD.LEVEL] = 0; 
					}
					
				break;
				
				case BUILDING.SAWMIL:
				
				var woodGain = 0;
				
				if (workers > 0) {
					repeat(workers) 
					{
						var _wmX = 0;
						var _wmY = 0;
						var currentBuildLevel = 0;
						var prevBuildLevel = -1;
							
						for (var wmX = mX - 1; wmX < mX + 2; wmX++)
						{
							for (var wmY = mY - 1; wmY < mY + 2; wmY++)
							{
								var buildAdjData = global.buildings[# wmX, wmY];
								var buildAdjBuidlings = buildAdjData[BUILD.BUILDING];
								var buildAdjLevel = buildAdjData[BUILD.LEVEL];
							
								if (buildAdjBuidlings == BUILDING.FORREST)
								{
									if (buildAdjLevel > prevBuildLevel)
									{
										currentBuildLevel = buildAdjLevel;
										_wmX = wmX;
										_wmY = wmY;
										prevBuildLevel = currentBuildLevel;
									}
								}
	
							}
						}
					
						var buildAdjData = global.buildings[# _wmX, _wmY];
						var buildAdjBuidlings = buildAdjData[BUILD.BUILDING];
						var buildAdjLevel = buildAdjData[BUILD.LEVEL];
						
						woodGain += (2 * (buildAdjLevel)*(buildLevel-1));
						
						buildAdjData[@ BUILD.BUILDING] = BUILDING.NOTHING;
						buildAdjData[@ BUILD.LEVEL] = 0; 
					}
				}
				
				wood += round(woodGain);
				
				break;
				
				case BUILDING.TOWNHALL:
					
					turn_til_Draft -= workers;
					
					if (buildLevel > 2)
					{
						draft_choice_no = 4;
					}
					
				break;
			
			}

			// Reset worker grid
			var tileWorkers = [0];
			global.workers[# mX, mY] = tileWorkers;
		}
	}
	
	current_pop = pop;
	prev_turn = turn;
}