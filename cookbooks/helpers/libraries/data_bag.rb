class Chef
  class Recipe
    def data_bag_item_maybe(bag, item, default = nil)
      if data_bag(bag).include? item
        data_bag_item(bag, item)
      else
        Hash.new(default)
      end
    end
  end
end
