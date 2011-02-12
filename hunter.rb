class Hunter
  
  def initialize(game_window, runner,x=nil, y=nil)
    @game_window = game_window
    @icon = Gosu::Image.new(@game_window, "images/hunter.png", true)
    @x = x || -(rand(@game_window.width))
    @y = y || -(rand(@game_window.height))
    @maxspeed = rand(4)+2
    @speed = 2
    @runner = runner
  end
  def change_speed
    @speed= @speed +1 unless @speed == @maxspeed
  end
  def x
    @x
  end
  def y
    @y
  end
  def set_x_y
    @x = rand(@game_window.width) 
    @y = rand(@game_window.height)
  end
 
  def chase
    if @runner.x < @x
      @x = @x - @speed
    elsif @runner.x > @x
      @x = @x + @speed
    end
    
    if @runner.y < @y
      @y = @y - @speed
    elsif @runner.y > @y
      @y = @y + @speed
    end
    
  end
  
  def cross_screen
    @x = @x + @speed
  end
  
  
  def draw
    @icon.draw(@x,@y,20)
  end
  
end
