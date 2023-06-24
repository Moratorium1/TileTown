/// @description Insert description here
// You can write your code in this editor
if (selected == true)
{
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
					
				if (buildBuilding == BUILDING.NOTHING || buildBuilding == building_no && max_level > buildLevel) 
				{
					var preview_level = buildLevel + 1;
					
					if (preview_level > max_level)
					{
						preview_level--;	
					}
					
					if (buildBuilding == BUILDING.NOTHING)
					{
						preview_level = 0;	
					}
				
					// Preview Building
					draw_sprite_ext(card_sprite, preview_level, 896, 64, 2, 2, 0, c_white, 0.5);
					
					// Show Cost
					// Wood
					if (wood != 0) {
						draw_sprite_ext(s_Wood, 1, 904, 240, 2, 2, 0, c_white, 1);
						draw_set_color($2E1814);
						draw_text(904, 240, -wood);
					}
					
					// Stone
					if (stone != 0) {
					draw_sprite_ext(s_Stone, 1, 904, 304, 2, 2, 0, c_white, 1);
					draw_text(904, 304, -stone);
					}
				}
				else if (buildBuilding == building_no && buildLevel >= max_level && workable == true)
				{
					// Draw Workers
					var preview_index = workers + 1;
					
					if (preview_index >= 4)
					{
						preview_index = 0;	
					}
						
					draw_sprite_ext(s_Workers, preview_index, 896, 176, 2, 2, 0, c_white, 0.5);
				}
				else if (buildBuilding == BUILDING.BLACKSMITH && buildLevel >= 2)
				{
					var _cost = 4 / (buildLevel-1);
					
					draw_sprite_ext(s_Iron, 1, 904, 240, 2, 2, 0, c_white, 1);
					draw_set_color($2E1814);
					draw_text(904, 240, -_cost);
				}
			}
		}
	}
}