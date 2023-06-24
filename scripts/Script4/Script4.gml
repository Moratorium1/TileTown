// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function get_hover(width, height){

	var mouse_gui_x = device_mouse_x_to_gui(0);
	var mouse_gui_y = device_mouse_y_to_gui(0);

	return (point_in_rectangle(mouse_gui_x, mouse_gui_y, x - width, y - height, x + width, y + height))
}