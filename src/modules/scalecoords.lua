local c = {}

function c.screenWidth()

end

function c.screenHeight()

end

-- convert pixels to percent of screen coords --
function c.toPercent(x, y)
	local result

	result.x = (x / c.screenWidth()) * 100
	result.y = (y / c.screenHeight()) * 100

	return result
end

-- convert percent coords to pixels relative to top left of screen --
function c.toPixels(x, y)
	local result

	result.x = (x / 100) * c.screenWidth()
	result.y = (y / 100) * c.screenHeight()

	return result
end

return c