#!/usr/bin/env ruby
require 'rubygems'
require 'chingu'

class Platformer < Gosu::Window
  
  def initialize
    super(1024, 768, false)
  end
  
  def setup
    switch_game_state(Game)
  end
  
end

game = Platformer.new
game.show