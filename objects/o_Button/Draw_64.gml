/// @description Insert description here
// You can write your code in this editor

draw_set_font(fnt_pixel);
draw_set_color($DFE0E8);
draw_set_halign(fa_center);
//draw_sprite_ext(s_Button, 1, x, y, _xScale, _yScale, 0, c_white, 1);
draw_text_ext_transformed(x, y, text, 4, 512, _xScale/4, _yScale/4, 0);