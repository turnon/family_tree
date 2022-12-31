require "family_tree/version"
require "tree_graph"
require "tree_html"

module FamilyTree
  class Node
    include TreeGraph
    include TreeHtml

    attr_reader :klass, :descendants

    alias_method :label_for_tree_graph, :klass
    alias_method :label_for_tree_html, :klass

    def initialize(klass)
      @klass = klass
      @descendants = []
    end

    def sorted_children
      descendants.sort_by{ |d| d.klass.name }
    end

    alias_method :children_for_tree_html, :sorted_children
    alias_method :children_for_tree_graph, :sorted_children
  end

  class << self
    def of(klasses)
      root = Node.new(::BasicObject)

      Array(klasses).each do |k|
        parent = root

        k = ::Object.const_get(k) if String === k

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

    def html(klasses)
      of(klasses).tree_html_full
    end
  end
end
