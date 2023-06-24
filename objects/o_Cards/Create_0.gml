hand_size = STARTING_HANDSIZE;

deck = ds_list_create();
hand = ds_list_create();
discard = ds_list_create();

turn_one = true;

for (var i = 0; i < 11; i++)
{
	var card = 0;
	switch(i)
	{
		// STARTING DECK
		
		// FOOD TILES
		case 0:
			card = BUILDING.FIELD;
		break;
		
		case 1:
			card = BUILDING.FIELD;
		break;
			
		// STONE TILES
		case 2:
			card = BUILDING.QUARRY;
		break;
			
		case 3:
			card = BUILDING.QUARRY;
		break;
		
		// WOOD TILES
		case 4:
			card = BUILDING.FORREST;
		break;
		
		case 5:
			card = BUILDING.FORREST;
		break;
		
		// DRAFT TILES
		case 6:
			card = BUILDING.TOWNHALL;
		break;
			
		case 7:
			card = BUILDING.TOWNHALL;
		break;
		
		case 8:
			card = BUILDING.WINDMILL;
		break;
		
		case 9:
		// Sawmil
			card = BUILDING.SAWMIL;
		break;
		
		case 10:
		// Sawmil
			card = BUILDING.MONUMENT;
		break;
		
	}
	
	ds_list_add(deck, card);	
}