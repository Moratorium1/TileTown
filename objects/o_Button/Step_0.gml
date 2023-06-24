/// @description Insert description here
// You can write your code in this editor
var _hover = get_hover(width, height);
var _click = _hover && mouse_check_button_pressed(mb_left);

if (_hover)
{
	show_debug_message("hover");
	_xScale = lerp(_xScale, 8, 0.1);
	_yScale = lerp(_yScale, 8, 0.1);
}
else
{
	_xScale = lerp(_xScale, 4, 0.1);
	_yScale = lerp(_yScale, 4, 0.1);
}

if (_click && script_ >= 0)
{
	show_debug_message("click")
	script_execute(script_);	
}