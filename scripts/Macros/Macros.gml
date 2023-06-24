// ISOMETRIC DISPLAY MACROS
#macro TILE_W 64
#macro TILE_H 32
#macro ROOM_W room_width
#macro ROOM_H room_height
#macro MAP_W 16
#macro MAP_H 16
#macro MAP_X_OFFSET 0.5
#macro MAP_Y_OFFSET 0.3

// CARD DISPLAY MACROS
#macro HAND_Y 672
#macro HAND_X 1000
#macro STARTING_HANDSIZE 4
#macro HANDSIZE_MAX 8

//
#macro STONE o_Grid.stone
#macro WOOD o_Grid.wood
#macro IRON o_Grid.iron

// GAME MACROS
#macro STARTING_FOOD 20
#macro STARTING_WOOD 20
#macro STARTING_POP 3

#macro STARTING_STONE 8
#macro STARTING_STONECAP 20

#macro STARTING_IRON 0
#macro STARTING_IRONCAP 10

// Tile enum
enum TILE
{
	TERRAIN,
	Z,
}

enum TERRAIN
{
	DIRT,
	GRASS,
	WATER,
	FERTILE
}

// Building enum
enum BUILD 
{
	BUILDING, 	// Determines the bulding placed on the tile - If zero no building had been placed
	LEVEL,		// Determines the level of the building from foundations, 
	Z,
}

enum BUILDING
{
	NOTHING,
	
	// WOOD TIER
	
	FORREST,
	QUARRY,
	FIELD,
	WINDMILL,
	SILO,
	SAWMIL,
	LUMBERYARD,
	TOWNHALL,
	BLACKSMITH,
	HOUSE,
	STONEYARD,
	MINE,
	MONUMENT,
	
	// STONE TIER
	
	WINDMILL_STONE = BUILDING.WINDMILL + 50,
	WINDMILL_SILO = BUILDING.SILO + 50,
	SAWMIL_STONE = BUILDING.SAWMIL + 50,
	LUMBERYARD_STONE = BUILDING.LUMBERYARD + 50,
	TOWNHALL_STONE = BUILDING.TOWNHALL + 50,
	BLACKSMITH_STONE = BUILDING.BLACKSMITH + 50,
	HOUSE_STONE = BUILDING.HOUSE + 50,
	STONEYARD_STONE = BUILDING.STONEYARD + 50,
	MINE_STONE = BUILDING.MINE + 50
	
}
