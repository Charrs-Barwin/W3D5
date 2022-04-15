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
    
end