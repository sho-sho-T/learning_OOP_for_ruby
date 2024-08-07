# 依存方向の管理

# 依存関係の逆転

class Gear
  attr_reader :chainring, :cog

  def initialize(chainring, cog)
    @chainring = chainring
    @cog = cog
  end

  def gear_inches(diameter)
    ratio * diameter
  end

  def ragio
    chainring / cog.to_f
  end
  # ...
end

class Wheel
  attr_reader :rim, :tire, :gear

  def initialize(rim, tire, gear)
    @rim = rim
    @tire = tire
    @gear = Gear.new(chainring, cog)
  end

  def diameter
    rim + (tire * 2)
  end

  def gear_inches
    gear.gear_inches(diameter)
  end
  # ...
end

Wheel.new(26, 1.5, 52, 11).gear_inches
