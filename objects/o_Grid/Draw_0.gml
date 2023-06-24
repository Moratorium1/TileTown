/// @description Insert description here
// You can write your code in this editor
draw_set_font(fnt_pixel);
// set colour to the sprite outline colour
draw_set_color($2E1814);

draw_sprite_ext(s_Food, 1, 192, 64, 2, 2, 0, c_white, 1);
draw_text(160, 64, food);
draw_text(192, 64, "/");
draw_text(224, 64, food_cap);

draw_sprite_ext(s_Wood, 1, 192, 128, 2, 2, 0, c_white, 1);
draw_text(160, 128, wood)
draw_text(192, 128, "/");
draw_text(224, 128, wood_cap);

draw_sprite_ext(s_Stone, 1, 192, 192, 2, 2, 0, c_white, 1);
draw_text(160, 192, stone);
draw_text(192, 192, "/");
draw_text(224, 192, stone_cap);

draw_sprite_ext(s_Iron, 1, 192, 256, 2, 2, 0, c_white, 1);
draw_text(160, 256, iron);
draw_text(192, 256, "/");
draw_text(224, 256, iron_cap);


draw_sprite_ext(s_Pop, 1, 192, 664, 2, 2, 0, c_white, 1);
draw_text(224, 664, pop_cap);
draw_text(192, 664, "/");
draw_text(160, 664, current_pop);


draw_set_color(c_white);

if (draft == true && was_draft == false)
{
	draftable = ds_list_create();
	
	for (var i = 0; i < draft_choice_no; i++)
	{
		ds_list_add(draftable, irandom_range(BUILDING.FORREST, BUILDING.MONUMENT));
	}

	was_draft = draft;
}



for (var mX = 0; mX < MAP_W; mX++)
{
	for (var mY = 0; mY < MAP_H; mY++)
	{
		var mapData = global.map[# mX, mY];	
		var buildData = global.buildings[# mX, mY];
		
		var tileZ = mapData[TILE.Z];
		var tileSprite = mapData[TILE.TERRAIN];
		
		var buildZ = buildData[BUILD.Z];
		var buildBuilding = buildData[BUILD.BUILDING];
		var buildLevel = buildData[BUILD.LEVEL];
		
		
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
		
		if (ScreenTileX(mouse_x, mouse_y) == mX) && ((ScreenTileY(mouse_x, mouse_y) == mY))
		{
				tileZ = -10;
		}
		
			var tileX = TileToScreenX(mX, mY);
			var tileY = TileToScreenY(mX, mY);
			
			draw_sprite(sprite, 1, tileX, tileY + tileZ);
			
		if (ScreenTileX(mouse_x, mouse_y) == mX) && ((ScreenTileY(mouse_x, mouse_y) == mY))
		{
				draw_sprite(s_Cursor, 1, tileX, tileY);
		}	
			
			if (buildBuilding != target)
			{
				draw_sprite(building, buildLevel, tileX, tileY + tileZ);
			}
			else
			{
				draw_sprite_ext(building, buildLevel, tileX, tileY + tileZ, 1, 1, 0, c_yellow, 1);	
			}
			
	}
}

draw_text_ext(800, 632, "Space to end turn", 32, 128*3);