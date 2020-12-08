class Bag
  attr_accessor :name, :bags

  def initialize(name:, bags: [])
    @name = name
    @bags = bags
  end

  def flatten_bags
    bags.map { |bag| bags.map(&:name) + bag.flatten_bags }
        .flatten
  end
end
