function EffectBoxes_COMMON() {
	#macro EFFECTBOX_BUFF_1 0
	#macro EFFECTBOX_PERMANENT_BUFF_1 1
}

function effectBox_is_equal_COMMON(effectBox1, effectBox2) {
	if (effectBox1 == undefined or effectBox2 == undefined)
		return false
		
	return effectBox1.code == effectBox2.code and effectBox1.owner == effectBox2.owner and effectBox1.creator == effectBox2.creator and effectBox1.level == effectBox2.level and effectBox1.maxTime == effectBox2.maxTime
}
