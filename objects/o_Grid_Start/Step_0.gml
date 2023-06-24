/// @description Insert description here
// You can write your code in this editor

timer += delta_time*0.00001;

if (timer >= timer_max)
{
	instance_destroy();
	
	instance_create_layer(x,y, "Instances", o_Grid_Start);
}

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
