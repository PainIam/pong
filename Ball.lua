

Ball = Class {}

function Ball:init(x, y, width, height)

    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.dy = 0
    self.dx = 0

end

-- places ball in middle of screen

function Ball:reset()

    self.x = VIRTUAL_WIDTH / 2 -2
    self.y = VIRTUAL_HEIGHT / 2 - 2
    self.dy = 0
    self.dx = 0

end

function Ball:collides(paddle)

    --AABB Collision detection - gap method

    if self.x + self.width < paddle.x   or
       self.x > paddle.x + paddle.width or
       self.y + self.height < paddle.y  or
       self.y > paddle.y + paddle.height then
            return false -- there exists a gap
    else  
        return true -- no gap, there is a collision buddy you might be cooked
    end
end


function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:render()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end