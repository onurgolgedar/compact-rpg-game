function FG_light_behavior_broken() {
	strong = min(((cos(x)+100 + current_time/10) mod 250) div 10, 1) / 2 + 0.5
	strong *= min(((cos(y)+100 + current_time/15) mod 200) div 5, 1) / 2 + 0.5


}
