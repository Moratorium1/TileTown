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
		
		var tileX = TileToScreenX(mX, mY);
		var tileY = TileToScreenY(mX, mY);
			
		draw_sprite(sprite, 1, tileX, tileY + tileZ);
		draw_sprite(building, buildLevel, tileX, tileY + tileZ);
}
}

