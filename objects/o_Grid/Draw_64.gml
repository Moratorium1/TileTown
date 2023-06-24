/// @description Insert description here
// You can write your code in this editor
//draw_text(100, 100, "pop : " + string(pop));
//draw_text(100, 140, "turn : " + string(turn));
//draw_text(100, 160, "wood : " + string(wood));
//draw_text(100, 180, "stone : " + string(stone));

draw_set_halign(fa_center);

var _center_x = ROOM_W/2;
var _center_y = ROOM_H/2;

if (victory == true)
{
	draw_text(_center_x+64, _center_y-288, "Victory - Thanks for Playing");
	draw_text(_center_x+64, _center_y-224, "Turns taken: ");
	draw_text(_center_x+(64*3), _center_y-224, turn);
	draw_text(_center_x+64, _center_y-160, "Press R to restart");
}
else if (defeat == true)
{
	draw_text(_center_x+64, _center_y-288, "Defeat - Population is zero");
	draw_text(_center_x+64, _center_y-224, "Turns taken: ");
	draw_text(_center_x+(64*3), _center_y-224, turn);
	draw_text(_center_x+64, _center_y-160, "Press R to restart");
}


if (continue_ == false) 
{
	draw_text(_center_x, _center_y-288, "R to Generate a New Map");
	draw_text(_center_x, _center_y-224, "Space to Continue");
}

if (info == true)
{
	draw_sprite_ext(s_info, 1, _center_x+96, _center_y-32, 2, 2, 0, c_white, 1);
	draw_text(_center_x, 64, "TILE INFO");
	
	for (var i = _top; i < _bot; i++)
	{
		draw_set_font(fnt_pixel_info);
		
		
		
		var buildBuilding = i;
		var building = s_Nothing;
		var _y = -(_top - i);
		var text = " ";
		
		switch(buildBuilding)
			{
				case BUILDING.FORREST:
					building = s_Resource_Forrest;
					text = "Forests grow each turn, provide 2 wood per worker, and decrease in level per worker"
				break;
			
				case BUILDING.QUARRY:
					building = s_Resource_Quarry;
					text = "Quarries provide 2 stone per worker, with a chance to gain iron"
				break;
			
				case BUILDING.FIELD:
					building = s_Build_Field;
					text = "Fields grow each turn and can only be worked at full growth, they provide 4 food per worker but return to level 1"
				break;
			
				case BUILDING.WINDMILL:
					building = s_Build_Windmil;
					text = "Windmills work all adjacent field tiles for x 0.5 value for wood, x 1 value for stone"
				break;
			
				case BUILDING.SAWMIL:
					building = s_Build_Sawmil;
					text = "Sawmils Chop down the highest level adjacent forest tile per worker, providing 2 wood per forest level or 4 wood per forest level at stone "
				break;
			
				case BUILDING.TOWNHALL:
					building = s_Build_Townhall;
					text = "The Townhall offers the player 3 tiles to draft from every 9 turns, each worker reduces this by a turn. Upgrading to stone offers an additional draft choice - The townhall is unique and only one can be placed"
				break;
			
				case BUILDING.HOUSE:
					building = s_Build_House;
					text = "Houses increases the maximum population of the town, wood tier provides +1 housing and stone +2."
				break;
				
				case BUILDING.BLACKSMITH:
					building = S_Build_Blacksmith;
					text = "Playing a wooden tier card to the blacksmith will upgrade the card to stone tier at the cost of 4 Iron. Upgrading the blacksmith reduces the upgrade cost to 2"
				break;
			
				case BUILDING.SILO:
					building = s_Build_Silo;
					text = "Increases food storage, wood tier provides +10 and stone + 20"
				break;
			
				case BUILDING.LUMBERYARD:
					building = s_Build_Lumberyard;
					text = "Increases wood storage, wood tier provides +10 and stone + 20"
				break;
			
				case BUILDING.STONEYARD:
					building = s_Build_Stoneyard;
					text = "Increases stone storage, wood tier provides +10 and stone + 20"
				break;
			
				case BUILDING.MINE:
					building = s_Build_Mine;
					text = "Increases the odds that addjacent quarries tiles provide iron, upgrading to stone further increases the odds, each worker decreases the odds further"
				break;
			
				case BUILDING.MONUMENT:
					building = s_Build_Monument;
					text = "Completion of the monument completes the game"
				break;
			}
			
			draw_set_color($2E1814);
			draw_sprite(s_Tile_Grass, 1, _center_x - 160, (96*_y) + _center_y/3);
			draw_sprite(building, 2, _center_x - 160, (96*_y) + _center_y/3);
			draw_text_ext(_center_x + 144, (96*_y) + _center_y/3, text, 16, 128*4);
	}
	
}

if (!info) 
{
	draw_text_ext(800, 600, "I for Tile Info", 32, 128*3);
	
	for (var mX = 0; mX < MAP_W; mX++)
	{
		for (var mY = 0; mY < MAP_H; mY++)
		{
			if (ScreenTileX(mouse_x, mouse_y) == mX) && ((ScreenTileY(mouse_x, mouse_y) == mY))
			{
					var mapData = global.map[# mX, mY];	
					var buildData = global.buildings[# mX, mY];
		
					var tileZ = mapData[TILE.Z];
					var tileSprite = mapData[TILE.TERRAIN];
		
					var buildZ = buildData[BUILD.Z];
					var buildBuilding = buildData[BUILD.BUILDING];
					var buildLevel = buildData[BUILD.LEVEL];
		
					var workerData = global.workers[# mX, mY];
					var workers = workerData[0];
		
					var sprite = s_Tile_Grass;
					var building = s_Nothing;
			
	
					switch(tileSprite)
					{
						case TERRAIN.DIRT:
							sprite = s_Tile_Dirt;
						break;
			
						case TERRAIN.GRASS:
							sprite = s_Tile_Grass;
						break;
			
						case TERRAIN.WATER:
							sprite = s_Tile_Water;
							mapData[@ TILE.Z] = 2;
						break;
			
						case TERRAIN.FERTILE:
							sprite = s_Tile_Fertile;
						break;
					}
		
					switch(buildBuilding)
					{
						case BUILDING.FORREST:
							building = s_Resource_Forrest;
						break;
			
						case BUILDING.QUARRY:
							building = s_Resource_Quarry;
						break;
			
						case BUILDING.FIELD:
							building = s_Build_Field;
						break;
			
						case BUILDING.WINDMILL:
							building = s_Build_Windmil;
						break;
			
						case BUILDING.SAWMIL:
							building = s_Build_Sawmil;
						break;
			
						case BUILDING.TOWNHALL:
							building = s_Build_Townhall;
						break;
			
						case BUILDING.BLACKSMITH:
							building = S_Build_Blacksmith;
						break;
			
						case BUILDING.HOUSE:
							building = s_Build_House;
						break;
			
						case BUILDING.SILO:
							building = s_Build_Silo;
						break;
			
						case BUILDING.LUMBERYARD:
							building = s_Build_Lumberyard;
						break;
					
						case BUILDING.STONEYARD:
							building = s_Build_Stoneyard;
						break;
					
						case BUILDING.MINE:
							building = s_Build_Mine;
						break;
					
						case BUILDING.MONUMENT:
							building = s_Build_Monument;
						break;
					}
				
					// Draw Tile
					draw_sprite_ext(sprite, 1, 896, 64, 2, 2, 0, c_white, 1);
				
					// Draw building
					draw_sprite_ext(building, buildLevel, 896, 64, 2, 2, 0, c_white, 1);
				
					// Draw Workers
					draw_sprite_ext(s_Workers, workers, 896, 176, 2, 2, 0, c_white, 1);
				
			}
		}
	}
}



if (draft == true && was_draft = true) 
{
	draw_text(ROOM_W/2, 64, "Select a new tile");
	
	for (var i = 0; i < ds_list_size(draftable); i++)
	{
		var _x = (i * 128 + room_width/4) - (64 * (draft_choice_no-3)) + 128;
		var buildBuilding = draftable[| i];
		var building = s_Nothing;
		
		switch(buildBuilding)
					{
						case BUILDING.FORREST:
							building = s_Resource_Forrest;
						break;
			
						case BUILDING.QUARRY:
							building = s_Resource_Quarry;
						break;
			
						case BUILDING.FIELD:
							building = s_Build_Field;
						break;
			
						case BUILDING.WINDMILL:
							building = s_Build_Windmil;
						break;
			
						case BUILDING.SAWMIL:
							building = s_Build_Sawmil;
						break;
			
						case BUILDING.TOWNHALL:
							building = s_Build_Townhall;
						break;
			
						case BUILDING.BLACKSMITH:
							building = S_Build_Blacksmith;
						break;
			
						case BUILDING.HOUSE:
							building = s_Build_House;
						break;
			
						case BUILDING.SILO:
							building = s_Build_Silo;
						break;
			
						case BUILDING.LUMBERYARD:
							building = s_Build_Lumberyard;
						break;
					
						case BUILDING.STONEYARD:
							building = s_Build_Stoneyard;
						break;
					
						case BUILDING.MINE:
							building = s_Build_Mine;
						break;
					
						case BUILDING.MONUMENT:
							building = s_Build_Monument;
						break;
					}
		
		if point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _x - 16, 128 - 32, _x + 16, 128 + 64)
		{
			show_debug_message(draftable[| i]);
			if (mouse_check_button_pressed(mb_left))
			{
				ds_list_add(o_Cards.discard, draftable[| i]);
				draft = false;
			}
		}
		
		draw_sprite(s_Tile_Grass, 1, _x, 128);
		draw_sprite(building, 2, _x, 128);
	}
}

if (draft == false && was_draft == true)
{
	ds_list_destroy(draftable);
	was_draft = false;
}

