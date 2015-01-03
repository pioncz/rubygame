require 'gosu'

class GameWindow < Gosu::Window
  def initialize
    super 640, 480, false
    self.caption = "FPS: 600"
    @image = Gosu::Image.new(self, "ruby_images/kannon.png", false)
    @missile = Gosu::Image.new(self, "ruby_images/missile.png", false)
    @mob = Gosu::Image.new(self, "ruby_images/mob.png", false)
    @y = 435.0
    @x = 45.0
    @vel_x = @vel_y = 0.0
    @angle = -45.0

    @TOP_COLOR = Gosu::Color.new(0xFF1EB1FA)
    @BOTTOM_COLOR = Gosu::Color.new(0xFF1D4DB5)

    @power = 4
    @move = false

    @mx = 2000.0
    @my = 200.0
    @mh = 15

    @dx = 1
    @dy = 1

    @x2 = 20

    @gravity = 10.0

      @moby = Random.rand(44)
      @mobx = Random.rand(40)
      @moby = @moby * 10
      @mobx = @mobx * 10 + 100
    @mobh = 41

    @background_image = Gosu::Image.new(self, "ruby_images/Space.png", true)
  end
  
  def update
    if (button_down? Gosu::KbRight) then
      if (@x2 < 120)
         @x2 += 2
      end
    end
    if (button_down? Gosu::KbLeft) then
      if (@x2 > 20)
         @x2 -= 2
      end
    end
    if (button_down? Gosu::MsLeft) then
      if @move == false then
         @mx = @x
         @my = @y
         @dx = 2 - (- @angle) / 45
         @dy = (- @angle) / 45
         @move = true
         @power = ((@x2 - 20) * 2.16)/100 + 0.5
      end
    end
    if @move==true then
      @mx += (@dx * @power) * 5
      @my -= (@dy * @power) * 5
      @dy -= (@gravity / 1500.0) * 5
    end
    if @mx > 640 || @my > 480 || @mx < 0 || @my < 0 then
      @move = false
      @mx = -200
      @my = -200
    end
    if check_collision then
      @moby = Random.rand(44)
      @mobx = Random.rand(40)
      @moby = @moby * 10
      @mobx = @mobx * 10 + 100
      @move = false
      @mx = -200
      @my = -200
   end
      @angle = Math::atan2(mouse_y - @y, mouse_x - @x) * 180 / Math::PI
  end
  
  def draw
    if @power_on then
       #power ma latac
    end
    @color = Gosu::Color.new(0xffff5544)
    @x1 = 20
    @h = 40
    draw_quad(
     @x1, @x1, @BOTTOM_COLOR,
     @x2, @x1, @TOP_COLOR,
     @x1, @h, @BOTTOM_COLOR,
     @x2, @h, @TOP_COLOR,
     3)
    @image.draw_rot(@x, @y, 2, @angle)
    @missile.draw_rot(@mx, @my, 3, 0.0)
    @background_image.draw(0, 0, 0)
    @mob.draw(@mobx,@moby,1)
  end

  #lewy missile, mx, my, mh
  #prawy mob, mobx, moby, mobh

  def check_collision
    ret = true
    if @mobx > (@mx+@missile.width)
      ret = false
    end
    if (@mobx + @mob.width) < @mx
      ret = false
    end
    if (@mob.height+@moby) < @my
      ret = false
    end
    if @moby > (@my+@missile.height)
      ret = false
    end
    return ret
  end
end

window = GameWindow.new
window.show