#!/usr/bin/env ruby
require 'rubygems'
require 'game'

class Platformer < Gosu::Window
  
  def initialize
    super(1024, 768, false)
  end
  
  def draw
  end
  
  def update
  end
  
end

game = Platformer.new
game.show