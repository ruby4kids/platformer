class PowerUp

  def initialize(game_window)
    @game_window = game_window

    @height = @game_window.height
    @width = @game_window.width

    @icon = Gosu::Image.new(@game_window, "images/nukeimage.png", true)
  end
  def draw
    @y = rand(@height)
    @x = rand(@width)
    @icon.draw(@x,@y,25)
  end
end
