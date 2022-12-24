require "test_helper"

class FamilyTreeTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::FamilyTree::VERSION
  end

  class A; end

  class B; end

  class C < B;end

  module M; end

  module N; end

  class D < C
    include M
    prepend N
  end

  class E < C; end

  def test_family_tree
    tree = <<~EOS
      BasicObject
      └─Object
        ├─FamilyTreeTest::A
        └─FamilyTreeTest::B
          └─FamilyTreeTest::C
            ├─FamilyTreeTest::D
            └─FamilyTreeTest::E
    EOS

    assert_equal tree.chomp, FamilyTree.graph([A, B, C, E, D, M])
  end
end
