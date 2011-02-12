class Player
  attr_reader :x, :y

  def initialize(window, x, y)
    @x, @y = x, y
    @dir = :left
    @vy = 0 # Vertical velocity
    @map = window.map
    # Load all animation frames
    #@standing, @walk1, @walk2, @jump =
     #*Image.load_tiles(window, "media/CaptRuby.png", 50, 50, false)
    # This always points to the frame that is currently drawn.
    # This is set in update, and used in draw.
    @image = Image.new(window, "images/ninjastick2.png", false)
  end
  
  def draw
    # Flip vertically when facing to the left.
    if @dir == :left then
      offs_x = -25
      factor = 1.0
    else
      offs_x = 25
      factor = -1.0
    end
    @image.draw(@x + offs_x, @y - 49, 0, factor, 1.0)
  end
  
  # Could the object be placed at x + offs_x/y + offs_y without being stuck?
  def would_fit(offs_x, offs_y)
    # Check at the center/top and center/bottom for map collisions
    not @map.solid?(@x + offs_x, @y + offs_y) and
      not @map.solid?(@x + offs_x, @y + offs_y - 45)
  end
  
  def touch?(hunters)
    hunters.any? {|h| Gosu::distance(@x, @y, h.x, h.y) < 10}
  end
  
  def update(move_x)
    # Select image depending on action
    if (move_x == 0)
      @cur_image = @standing
    else
      @cur_image = (milliseconds / 175 % 2 == 0) ? @walk1 : @walk2
    end
    if (@vy < 0)
      @cur_image = @jump
    end
    
    # Directional walking, horizontal movement
    if move_x > 0 then
      @dir = :right
      move_x.times { if would_fit(1, 0) then @x += 1 end }
    end
    if move_x < 0 then
      @dir = :left
      (-move_x).times { if would_fit(-1, 0) then @x -= 1 end }
    end

    # Acceleration/gravity
    # By adding 1 each frame, and (ideally) adding vy to y, the player's
    # jumping curve will be the parabole we want it to be.
    @vy += 1
    # Vertical movement
    if @vy > 0 then
      @vy.times { if would_fit(0, 1) then @y += 1 else @vy = 0 end }
    end
    if @vy < 0 then
      (-@vy).times { if would_fit(0, -1) then @y -= 1 else @vy = 0 end }
    end
  end
  
  def try_to_jump
    if @map.solid?(@x, @y + 1) then
      @vy = -20
    end
  end
end
