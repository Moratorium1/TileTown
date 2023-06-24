/// @description Insert description here
// You can write your code in this editor

if (continue_ == false || defeat == true || victory == true) {

	if (keyboard_check_pressed(ord("R")))
	{
		room_restart();	
	}
	
	if (keyboard_check_pressed(vk_space))
	{
		instance_create_layer(x, y , "Cards", o_Cards);
		continue_ = true;
	}
	
}

if (continue_ == true) {
	if (keyboard_check_pressed(vk_space))
	{
		turn++;
		show_debug_message(turn);
	}
}

if (keyboard_check_pressed(ord("I")))
{
	info = !info;
}

if (info)
{
	if (keyboard_check_pressed(vk_up) && _top != BUILDING.FORREST)
	{
		_top--;
		_bot--;
	}
	else if (keyboard_check_pressed(vk_down) && _bot != BUILDING.MONUMENT + 1)
	{
		_top++;
		_bot++;
	}
			
}

if (keyboard_check_pressed(ord("F")))
{
	window_set_fullscreen(true);
}

if (keyboard_check_pressed(ord("H")))
{
	window_set_fullscreen(false);
}

if (pop >= 10)
{
	victory = true;	
}

if (pop <= 0)
{
	show_debug_message("lost");
	defeat = true;
}

// Every fram loop through the grid checking for tile interactions
var _pop_cap = 0;
var _food_cap = 0;
var _wood_cap = 0;
var _stone_cap = 0;


for (var mX = 0; mX < MAP_W; mX++)
{
	for (var mY = 0; mY < MAP_H; mY++)
	{
		// Get tile data
		var mapData = global.map[# mX, mY];
		var tileZ = mapData[TILE.Z];
		var tileTerrain = mapData[TILE.TERRAIN];
		
		// Get build data
		var buildData = global.buildings[# mX, mY];
		var buildBuidlings = buildData[BUILD.BUILDING];
		var buildLevel = buildData[BUILD.LEVEL];
		
		// CHECK THE RESCOURCE CAPS
		// POP
		if (buildBuidlings == BUILDING.HOUSE && buildLevel >= 2)
		{
			_pop_cap += 2 * (buildLevel - 1);	
		}
		
		// FOOD
		if (buildBuidlings == BUILDING.SILO && buildLevel >= 2)
		{
			_food_cap += 10 * (buildLevel - 1);	
		}
		
		// WOOD
		if (buildBuidlings == BUILDING.LUMBERYARD && buildLevel >= 2)
		{
			_wood_cap += 10 * (buildLevel - 1);	
		}
		
		// STONE
		if (buildBuidlings == BUILDING.STONEYARD && buildLevel >= 2)
		{
			_stone_cap += 10 * (buildLevel - 1);	
		}
		
		// VICTORY
		if (buildBuidlings == BUILDING.MONUMENT && buildLevel >= 2)
		{
			victory = true;	
		}
		
		// Work out which tile mouse is over
		if (ScreenTileX(mouse_x, mouse_y) == mX) && ((ScreenTileY(mouse_x, mouse_y) == mY))
		{
			draw_text(50, 180, mX);
			draw_text(50, 180, mY);
		}
		
		// Check tiles adjacent water tiles - if tile Z of water tile is lower than water tile turn into water
		if (tileTerrain == TERRAIN.WATER)
		{
			for (var i = 0; i < 4; i++)
			{
				var _mX; 
				var _mY;
				
				switch(i)
				{
					case 0:
						_mX = 1;
						_mY = 0;
					break
					
					case 1:
						_mX = -1;
						_mY = 0;
					break
					
					case 2:
						_mX = 0;
						_mY = 1;
					break
					
					case 3:
						_mX = 0;
						_mY = -1;
					break;	
				}
				
				if (mX == 0 && _mX == -1) || (mX == MAP_W - 1 && _mX == 1)
				{
					_mX = 0;	
				}
				
				if (mY == 0 && _mY == -1) || (mY == MAP_H - 1 && _mY == 1)
				{
					_mY = 0;	
				}
				
				var tileAdjacentData = global.map[# mX + _mX, mY + _mY];
				var tileAdjacentTerrain = tileAdjacentData[TILE.TERRAIN];
				var tileAdjacentZ = tileAdjacentData[TILE.Z];
				
				var buildAdjacentData = global.buildings[# mX + _mX, mY + _mY];
				var buildAdjacentBuidlings = buildAdjacentData[BUILD.BUILDING];
				
				if (tileAdjacentZ > tileZ)
				{
					tileAdjacentData[@ TILE.TERRAIN] = TERRAIN.WATER;
					tileAdjacentData[@ TILE.Z] = 2;
					
					buildAdjacentData[@ BUILD.BUILDING] = 0;
				}
				else if (tileAdjacentTerrain == TERRAIN.GRASS)
				{
					tileAdjacentData[@ TILE.TERRAIN] = TERRAIN.FERTILE;
				}
			}
		}	
	}
}

pop_cap = _pop_cap + STARTING_POP;
wood_cap = _wood_cap + STARTING_WOOD;
food_cap = _food_cap + STARTING_FOOD;
stone_cap = _stone_cap + STARTING_STONECAP;


