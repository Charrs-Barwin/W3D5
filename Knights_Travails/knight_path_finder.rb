require_relative "Polytree_node"

class KnightPathFinder
  @@POSSIBLE_OFFSETS = [[1,2],[1,-2],[-1,2],[-1,-2],[2,1],[2,-1],[-2,1],[-2,-1]].sort
  attr :root_node
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

  def self.existing_pos?(pos)
    pos.all?{|p| p >= 0 && p < 8}
  end


  def self.valid_moves(pos)
    valid_moves = @@POSSIBLE_OFFSETS.map{|offset|[pos[0] + offset[0], pos[1] + offset[1]]}
    valid_moves.select{|p|KnightPathFinder.existing_pos?(p)}
    # valid_moves.select{|p| p.all?{|c| c >= 0 && c < 8}}
  end

  def new_move_position(pos)
    new_positions = KnightPathFinder.valid_moves(pos) - @considered_positions
    @considered_positions += new_positions
    new_positions
  end

  def find_path(end_pos)
    node = root_node.dfs(end_pos)
    trace_path_back(node)
  end

  def trace_path_back(node)
    path = [node.value]
    parent = node.parent
    while parent
      path << parent.value
      parent = parent.parent
    end
    path.reverse
  end
end

kpf = KnightPathFinder.new([0, 0])
p kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
p kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]