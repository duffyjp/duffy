module ActiveRecord
  module NestedAttributes
    module ClassMethods
      alias_method :accepts, :accepts_nested_attributes_for
    end
  end

  module Associations
    module ClassMethods
      alias_method :habtm, :has_and_belongs_to_many
    end
  end
end
