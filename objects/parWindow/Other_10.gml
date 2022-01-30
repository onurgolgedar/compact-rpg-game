if (!isRefreshing) {
	minDepth = depth
	with (parWindow) {
		onFront = false
		if (depth <= other.depth and id != other.id) {    
			if (depth < other.minDepth)
			    other.minDepth = depth;
            
			depth += 2
		}
	}
	depth = minDepth

	onFront = true
}
else
	isRefreshing = false