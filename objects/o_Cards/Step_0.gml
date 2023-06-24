if (keyboard_check_pressed(ord("P")))
{
	hand_size++;	
}



if (o_Grid.turn != o_Grid.prev_turn) || (turn_one == true)
{	
	
	if (hand_size > HANDSIZE_MAX)
	{
		hand_size = HANDSIZE_MAX;	
	}

	instance_destroy(o_Card);
	
	//discard hand
	for (var i = 0; i < ds_list_size(hand); i++)
	{
		ds_list_add(discard, hand[| i]);	
	}
	
	//Clear hand
	ds_list_clear(hand);
	
	//show_debug_message("discard Start");
	for (var i = 0; i < ds_list_size(discard); i++)
	{
		show_debug_message(discard[| i]);	
	}
	//show_debug_message("discard End");
	
	if (ds_list_size(deck) < hand_size)
	{
		for (var i = 0; i < ds_list_size(deck); i++)
		{
			ds_list_add(discard, deck[| i]);	
		}

		ds_list_shuffle(discard);
		ds_list_copy(deck, discard);
		ds_list_clear(discard);
	}
	
	//Draw new hand
	for (var i = 0; i < hand_size; i++)
	{
		ds_list_add(hand, deck[| 0]);
		ds_list_delete(deck, 0);
	}
	
	// Create cards
//	show_debug_message("hand Start");
	for (var i = 0; i < hand_size; i++)
	{
		var _card_no = hand[| i];
		var _max_level = 2;
		var _stone = 0;
		var _wood = 0;
		var _iron = 0;
		var _unique = false;
		var _edge = false;
		var _workable = true;
		//show_debug_message(hand[| i])
		
		var building = s_Nothing;
	
		switch(_card_no)
		{
			case BUILDING.NOTHING:
				building = s_Nothing;
			break;
			
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
				_edge = true;
				_wood = 4;
			break;
			
			case BUILDING.WINDMILL_STONE:
				_card_no = BUILDING.WINDMILL;
				building = s_Build_Windmil;
				_edge = true;
				_max_level = 3
				_wood = 4;
				_stone = 4;
			break;
			
			case BUILDING.SAWMIL:
				building = s_Build_Sawmil;
				_edge = true;
				_wood = 4;
			break;
			
			case BUILDING.SAWMIL_STONE:
				_card_no = BUILDING.SAWMIL;
				building = s_Build_Sawmil;
				_edge = true;
				_max_level = 3;
				_wood = 4;
				_stone = 4;
			break;
			
			case BUILDING.TOWNHALL:
				building = s_Build_Townhall;
				_unique = true;
				_wood = 4;
			break;
			
			case BUILDING.TOWNHALL_STONE:
				_card_no = BUILDING.TOWNHALL;
				building = s_Build_Townhall;
				_unique = true;
				_max_level = 3;
				_wood = 4;
				_stone = 4;
			break;
			
			case BUILDING.BLACKSMITH:
				building = S_Build_Blacksmith;
				_workable = false;
				_wood = 4;
			break;
			
			case BUILDING.BLACKSMITH_STONE:
				building = S_Build_Blacksmith;
				_workable = false;
				_max_level = 3;
				_wood = 4;
				_stone = 4;
			break;
			
			case BUILDING.HOUSE:
				building = s_Build_House;
				_workable = false;
				_wood = 4;
			break;
			
			case BUILDING.SILO:
				building = s_Build_Silo;
				_workable = false;
				_wood = 4;
			break;
			
			case BUILDING.LUMBERYARD:
				building = s_Build_Lumberyard;
				_workable = false;
				_wood = 4;
			break;
			
			case BUILDING.STONEYARD:
				building = s_Build_Stoneyard;
				_workable = false;
				_wood = 4;
			break;
			
			case BUILDING.MINE:
				building = s_Build_Mine;
				_wood = 4;
				_iron = 4;
			break;
			
			case BUILDING.MONUMENT:
				building = s_Build_Monument;
				_workable = false;
				_unique = true;
				_wood = 20;
				_stone = 20;
			break;
			
		}
	
		var _card = instance_create_layer(HAND_X, HAND_Y, "Cards", o_Card);
	
		with (_card)
		{
			building_no = _card_no;
			card_sprite = building;
			_end_x = (i * 128 + room_width/4) - (64 * (o_Cards.hand_size-5));
			description = string(building);
			pos = i;
			max_level = _max_level;
			wood = _wood;
			stone = _stone;
			iron = _iron;
			unique = _unique;
			non_edge = _edge;
			workable = _workable;
		}
		
	}
	
		turn_one = false;
	//show_debug_message("hand End");
}
