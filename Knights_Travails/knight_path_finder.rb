require_relative "PolyTreeNode"

class KnightPathFinder
  @@POSSIBLE_OFFSETS[[1,2],[1,-2],[-1,2],[-1,-2],[2,1],[2,-1],[-2,1],[-2,-1]]

  def initialize(start_pos)
    @root_node = PolyTreeNode.new(start_pos)
    @considered_positions =[start_pos]
    build_move_tree
  end

  def build_move_tree
      queue = [@root_node]
      until queue.empty?
          node = queue.shift

          new_positions = new_move_position(node.value)

          new_positions.each do |p|
            new_node = PolyTreeNode.new(p)
            node.add_child(new_node)
            queue << new_node
          end

      end
  end

  def existing_pos?(pos)
    pos.all?{|p| p >= 0 && p < 8}
  end


  def self.valid_moves(pos)
    valid_moves = POSSIBLE_OFFSETS.map{|offset|[pos[0] + offset[0], pos[1] + offset[1]]}
    valid_moves.select{|p|existing_pos?(p)}
  end

  def new_move_position(pos)
    new_positions = KnightPathFinder.valid_moves(pos) - @considered_positions
    @considered_positions += new_positions
    new_positions
  end

end