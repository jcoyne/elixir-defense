defrecord Player, x: nil, y: nil, hp: 10, name: nil

defmodule PlayerBehavior do

  def tick(player, board) do
    player = player.x(player.x + 1)
    player
  end

  def attack(player, force) do
    player.hp(player.hp - force)
  end

end
