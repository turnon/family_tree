require "family_tree/version"
require "tree_graph"

module FamilyTree
  class Node
    include TreeGraph

    attr_reader :klass, :descendants

    alias_method :label_for_tree_graph, :klass

    def initialize(klass)
      @klass = klass
      @descendants = []
    end

    def children_for_tree_graph
      descendants.sort_by{ |d| d.klass.name }
    end
  end

  class << self
    def of(klasses)
      root = Node.new(::BasicObject)

      Array(klasses).each do |k|
        parent = root

        if String === k
          k = k.split('::').reduce(::Object){ |namespace, name| namespace.const_get(name) }
        end

        k.ancestors.reverse_each do |a|
          next unless Class === a
          next if ::BasicObject == a

          child = parent.descendants.detect{ |d| d.klass == a }

          unless child
            child = Node.new(a)
            parent.descendants << child
          end

          parent = child
        end
      end

      root
    end

    def graph(klasses)
      of(klasses).tree_graph
    end
  end
end
