-- runs once on startup
function love.load()
	love.physics.setMeter(64) -- the height of one meter in pixels
	world = love.physics.newWorld(0, 16*64, true) -- horizontal grav of 0, vertical grav of 9.81

	objects = {}

	-- create the ground
	objects.ground = {}
	objects.ground.body = love.physics.newBody(world, 650/2, 650-50/2) -- the physics body
	objects.ground.shape = love.physics.newRectangleShape(650, 50) -- the actual shape
	objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape) -- bind shape to body

	-- create the player
	objects.player = {}
	objects.player.body = love.physics.newBody(world, 650/2, 650/2, 'dynamic') -- dynamic allows it to move
	objects.player.shape = love.physics.newRectangleShape(100, 100)
	objects.player.fixture = love.physics.newFixture(objects.player.body, objects.player.shape, 1) -- with density of 1
	objects.player.fixture:setRestitution(0.2) -- let it bounce

	love.window.setMode(650, 650) -- 650 pixel square window
end

forceAmount = 1600

function love.keypressed(key)
	if key == 'space' then
		if love.keyboard.isDown('up') then
			print('Applying', forceAmount, 'in down direction')
			objects.player.body:applyLinearImpulse(0, forceAmount)
		end
		if love.keyboard.isDown('right') then
			print('Applying', forceAmount, 'in left direction')
			objects.player.body:applyLinearImpulse(-forceAmount, 0)
		end
		if love.keyboard.isDown('down') then
			print('Applying', forceAmount, 'in up direction')
			objects.player.body:applyLinearImpulse(0, -forceAmount)
		end
		if love.keyboard.isDown('left') then
			print('Applying', forceAmount, 'in right direction')
			objects.player.body:applyLinearImpulse(forceAmount, 0)
		end
	end
end

-- also runs continuously
function love.update(dt)
	world:update(dt) -- updates the physics
end

function love.draw()
	-- draw the ground
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.polygon('fill', objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))

	-- draw the player
	love.graphics.setColor(255, 0, 0, 255)
	love.graphics.polygon('fill', objects.player.body:getWorldPoints(objects.player.shape:getPoints()))
end