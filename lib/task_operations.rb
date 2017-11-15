module TaskOperations
  def change_position(direction)
    return move_higher if direction == :up
    return move_lower if direction == :down
  end
end
