class PolyTreeNode

    attr_reader :value, :parent, :children

    def initialize(value)
        @value = value
        @parent = nil
        @children =[]
    end

    def parent=(node = nil)
        parent.children.delete(self) if parent
        @parent = node 
        parent.children << self if parent 
    end

    def add_child(child)
        child.parent = self if !children.include?(child)
    end
    def remove_child(child)
        raise "node is not a child" if child.parent == nil
        child.parent = nil
    end

    def dfs(target_value)
        
        return self if self.value == target_value
        children.each do |c|
            # return c if c.value == target_value (only check with base case)
            results= c.dfs(target_value)
            return results if results
        end
        return nil
    end
     
    def bfs(target_value)
        # return self if self.value == target_value (not correct, only check in loop)
        my_queue = [self]
        until my_queue.empty?
            ele = my_queue.shift
            return ele if ele.value == target_value
            my_queue += ele.children
        end
    end
end