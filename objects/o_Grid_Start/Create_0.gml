// @desc Setup map

/*
	Create the map grid
	loop through the grid randomly assigning tiles
	Create a river
*/

randomize();

// Create map grid
global.map = ds_grid_create(MAP_W, MAP_H);

// Set all tiles grass - maybe should be dirt
for (var mX = 0; mX < MAP_W; mX++)
{
	for (var mY = 0; mY < MAP_H; mY++)
	{
		var thisTile = [0, 0];
		
		thisTile[TILE.TERRAIN] = 1;
		thisTile[TILE.Z] = irandom_range(-4, 4);
		
		global.map[# mX, mY] = thisTile;
	}
}

// Create a river - Selects a random row and sets all values to water
var mX = irandom_range(2, 10);
for (var mY = 0; mY < MAP_H; mY++)
{
	var thisTile = global.map[# mX, mY];
	
	thisTile[TILE.TERRAIN] = TERRAIN.WATER;
	global.map[# mX, mY] = thisTile;
}



/*
	Create the building grid
	Sets all buildings to nothing
	If tile isn't water rolls odds on a resource being present
	Set tile to resource rolled
*/

global.buildings = ds_grid_create(MAP_W, MAP_H);

for (var mX = 0; mX < MAP_W; mX++)
{
	for (var mY = 0; mY < MAP_H; mY++)
	{
		
		var tileData = global.map[# mX, mY];
		var tileZ = tileData[TILE.Z];
		var tileTerrain = tileData[TILE.TERRAIN];
		
		var tileBuild = [0, 0];
		var resourceOdds = 4;
		var resource = 0;
		var level = 0;
		var edge = false;
		
		
		if	(mX == 0 || mX == MAP_W-1 || mY == 0 || mY == MAP_H-1)
		{
			edge = true;
		}
		
		if (tileTerrain != TERRAIN.WATER)
		{	
			if ((resourceOdds == irandom(resourceOdds)))
			{
				resource = irandom(BUILDING.QUARRY);
				level = 2;
				
				if (edge)
				{
					resource = BUILDING.FORREST;	
				}
				
				if (resource = BUILDING.QUARRY)
				{
					level =  2; 	
				}
			}	
		}
		
		tileBuild[BUILD.BUILDING] = resource;
		tileBuild[BUILD.LEVEL] = level;
		tileBuild[BUILD.Z] = tileZ;
		global.buildings[# mX, mY] = tileBuild;
	}
}

/*
	Create the worker grid
	Set all tiles to 0 workers
*/

global.workers = ds_grid_create(MAP_W, MAP_H);

for (var mX = 0; mX < MAP_W; mX++)
{
	for (var mY = 0; mY < MAP_H; mY++)
	{
		var tileWorkers = [0];
		
		global.workers[# mX, mY] = tileWorkers;
	}
}


// target holds the of the cards target tile - e.g. A wood gathering card would assign target the value of BUILDING.FORREST
target = -1;

//card gen Management
townhallTurn = -1;
turn_til_Draft = 9;


// Resource Variables  
construct = 0;
trees = 0;
stone = 20;

wood = STARTING_WOOD;
wood_cap = STARTING_WOOD;

stone = STARTING_STONE;
stone_cap = STARTING_STONECAP;

iron = STARTING_IRON;
iron_cap = STARTING_IRONCAP;

food = STARTING_FOOD;
food_cap = STARTING_FOOD;

pop = STARTING_POP;
current_pop = STARTING_POP;
prev_pop = STARTING_POP;
pop_cap = STARTING_POP;

draft_choice_no = 3;
was_draft = false;
draft = false;

victory = false;

pop_growth = 0;

turn = 0;
prev_turn = -1;

timer = 0;
timer_max = 60;
timer_min = 0;