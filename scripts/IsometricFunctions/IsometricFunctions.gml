function TileToScreenX(_tX, _tY) {
	
	return ((_tX - _tY) * (TILE_W * 0.5)) + (ROOM_W * MAP_X_OFFSET);
	
}

function TileToScreenY(_tX, _tY) {
	
	return ((_tX + _tY) * (TILE_H * 0.5)) + (ROOM_H * MAP_Y_OFFSET);
	
}

function ScreenTileX(roomX, roomY) {
	
	var _roomX = roomX - (ROOM_W * MAP_X_OFFSET);
	var _roomY = roomY - (ROOM_H * MAP_Y_OFFSET);
	
	return floor( ( _roomX / (TILE_W * 0.5) + _roomY / (TILE_H * 0.5) ) * 0.5);
	
}

function ScreenTileY(roomX, roomY) {
	
	var _roomX = roomX - (ROOM_W * MAP_X_OFFSET);
	var _roomY = roomY - (ROOM_H * MAP_Y_OFFSET);
	
	return floor( ( _roomY / ( TILE_H * 0.5 ) - ( _roomX / (TILE_W * 0.5) ) ) * 0.5);
	
}

function GetBuildingSprite(buildBuilding) {
	
		switch(buildBuilding)
		{
			case BUILDING.FORREST:
				return s_Resource_Forrest;
			break;
			
			case BUILDING.QUARRY:
				return s_Resource_Quarry;
			break;
			
			case BUILDING.FIELD:
				return s_Build_Field;
			break;
			
			case BUILDING.WINDMILL:
				return s_Build_Windmil;
			break;
			
			case BUILDING.SAWMIL:
				return s_Build_Sawmil;
			break;
			
			case BUILDING.TOWNHALL:
				return s_Build_Townhall;
			break;
			
			case BUILDING.BLACKSMITH:
				return S_Build_Blacksmith;
			break;
			
		}
}