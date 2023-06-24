if (point_in_rectangle(mouse_x, mouse_y, x - 48, y - 64, x + 48, y + 128))
{
	
	image_xscale = lerp(image_xscale, 2, 0.1);
	image_yscale = lerp(image_xscale, 2, 0.1);
	_xScale = lerp(_xScale, 2, 0.1);
	_yScale = lerp(_yScale, 2, 0.1);
	y = 640; 
	sprite_offset = 0;

	if (mouse_check_button_pressed(mb_left))
	{
		show_debug_message(building_no);
		selected = true;
		
		if (keyboard_check_pressed(ord("B")))
		{
			instance_destroy();	
		}
	}
	else
	{
		x = lerp(x, _end_x, 0.1);
		y = lerp(y, _start_y, 0.1);
	}
		
}
else
{
	x = lerp(x, _end_x, 0.1);
	y = lerp(y, _start_y, 0.1);
	
	image_xscale = 1;	
	image_yscale = 1;
	_xScale = 1;
	_yScale = 1;
	sprite_offset = 0;
}

if (selected == true)
{
		x = mouse_x + 64;
		y = mouse_y - 64;	
		
		if (mouse_check_button_released(mb_left))
		{
			if (o_Grid.current_pop > 0)
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
							var _unique = true;
							var _edge = false;
						
							if (tileSprite != TERRAIN.WATER)
							{
								if (buildBuilding == BUILDING.NOTHING && STONE >= stone && WOOD >= wood && building_no != BUILDING.QUARRY)
								{
									if (unique = true)
									{
										for (var mUX = 0; mUX < MAP_W; mUX++)
										{
											for (var mUY = 0; mUY < MAP_H; mUY++)
											{
												var buildUniqueData = global.buildings[# mUX, mUY];
												var buildUniqueBuilding = buildUniqueData[BUILD.BUILDING];
													
												if (buildUniqueBuilding == building_no)
												{
													show_debug_message("not unique")
													_unique = false;
												}	
											}
										}
									}
									
									if (non_edge = true)
									{
										if	(mX == 0 || mX == MAP_W-1 || mY == 0 || mY == MAP_H-1)
										{
											_edge = true;
											show_debug_message("edge")
										}
										else
										{
											show_debug_message("not edge");	
										}
									}
								
									if (_unique == true || unique == false) && (_edge == false || non_edge == false) {
										buildData[@ BUILD.BUILDING] = building_no;
										buildData[@ BUILD.LEVEL] = 0;
										instance_destroy();
										o_Grid.current_pop -= 1;
										WOOD -= wood;
										STONE -= stone;
									}
	
								}
								else if (buildBuilding == building_no)
								{	
									if (buildLevel < max_level && buildBuilding != BUILDING.FIELD && buildBuilding != BUILDING.QUARRY && STONE >= stone && WOOD >= wood)
									{
											buildData[@ BUILD.LEVEL] += 1;
											instance_destroy();
											o_Grid.current_pop -= 1;
											WOOD -= wood;
											STONE -= stone;
											
									}
									else if (workers < 3 && buildLevel >= 2 && workable == true)
									{
										workerData[@ 0] += 1;
										instance_destroy();
										o_Grid.current_pop -= 1;
									}
								}
								else if (buildBuilding == BUILDING.BLACKSMITH && buildLevel >= 2 && building_no > 3)
								{
									/*
										if the card is being played to a completed blacksmith and the card is not a resource (build_no > 3)
										replace the value in the hand array for the card with a value 50 higher - a stone version of the card
									*/
									
									var _cost = 4 / (buildLevel-1);
									
									if (IRON >= _cost)
									{
										ds_list_replace(o_Cards.hand, pos, building_no + 50);
										IRON -= _cost;
										instance_destroy();	
									}
								}
							}
						}
					}
				}
			}
			
			selected = false;
		}
}

//else if (buildBuilding == BUILDING.STONEMASON && buildLevel < 2 && building_no > 3)
//{
//	ds_list_replace(hand, pos, building_no + )
//}