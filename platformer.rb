#!/usr/bin/env ruby
$LOAD_PATH.unshift File.dirname(__FILE__)
require 'rubygems'
require 'gosu'
require 'hunter'
include Gosu

require 'player'
require 'map'

module Tiles
  Grass = 0
  Earth = 1
end

class Platformer < Gosu::Window
  
  attr_reader :map

  def initialize
    super(640, 480, false)
    self.caption = "Platformer"
    @sky = Image.new(self, "images/ninja-skull2.png", true)
    @map = Map.new(self, "map.txt")
    @player = Player.new(self, 400, 100)
    # The scrolling position is stored as top left corner of the screen.
    @camera_x = @camera_y = 0
    @hunters = []
    @start_time = Time.now
    @font = Gosu::Font.new(self, Gosu::default_font_name, 60)
    @score = 0
  end
  
  def update
    @score = @score + 10000
    if Time.now > (@start_time+3)
      @start_time = Time.now
      @hunters << Hunter.new(self, @player)
    end
    move_x = 0
    move_x -= 5 if button_down? KbLeft
    move_x += 5 if button_down? KbRight
    @player.update(move_x) unless @player.touch?(@hunters)
    @hunters.each {|hunter| hunter.chase}
        # Scrolling follows player
    @camera_x = [[@player.x - 320, 0].max, @map.width * 50 - 640].min
    @camera_y = [[@player.y - 240, 0].max, @map.height * 50 - 480].min
  end
  

  
  def draw
    @font.draw("The score is: #{@score}", 20,20,5)
    @sky.draw 0, 0, 0
    translate(-@camera_x, -@camera_y) do
      @map.draw
      @player.draw
      @hunters.each {|hunter| hunter.draw}
    end
  end
  
  def button_down(id)
    if id == KbUp then @player.try_to_jump end
    if id == KbEscape then close end
  end
  
end

game = Platformer.new
game.show
