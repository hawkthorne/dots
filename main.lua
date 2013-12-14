local ground = {}
local balls = {}
local world = nil

function love.load()
  love.graphics.setFont(love.graphics.newFont(50))

  love.physics.setMeter(64)
  world = love.physics.newWorld(0, 9.81*64, true)

  --let's create the ground
  ground.body = love.physics.newBody(world, 650/2, 650-50/2)
  ground.shape = love.physics.newRectangleShape(650, 50)
  ground.fixture = love.physics.newFixture(ground.body, ground.shape) --attach shape to body

  love.graphics.setBackgroundColor(104, 136, 248)
end

function love.update(dt)
  world:update(dt) --this puts the world into motion
end

function love.mousepressed(x, y, button)
  if button == "l" then
    local ball = {}
    ball.body = love.physics.newBody(world, x, y, "dynamic")
    ball.shape = love.physics.newCircleShape(20)
    ball.fixture = love.physics.newFixture(ball.body, ball.shape, 1)
    ball.fixture:setRestitution(0.9)
    ball.body:applyForce(math.random() * -500, 0)
    table.insert(balls, ball)
  end
end

function love.draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.printf("dots.", 550/2, 50, 100, "center")
  
  love.graphics.setColor(72, 160, 14)
  love.graphics.polygon("fill", ground.body:getWorldPoints(ground.shape:getPoints()))

  love.graphics.setColor(193, 47, 14)

  for _, ball in pairs(balls) do
    love.graphics.circle("fill", ball.body:getX(), ball.body:getY(), ball.shape:getRadius())
  end
end
