module Collectable
  extend ActiveSupport::Concern


  module ClassMethods



    def collects(association, class_name: nil)
      # unless self.reflect_on_association(association.to_s.singularize.to_sym) or self.reflect_on_association(association.to_s.pluralize.to_sym)
      #   raise "#{self} doesn't reflect on #{association.to_s.singularize} or #{association.to_s.pluralize}, so it can't collect them"
      # end

      define_singleton_method association.to_sym do
        puts "  \e[35mCOLLECT: (#{self} -> #{association})\e[0m".upcase

        class_name ||= association.to_s.classify
        key          = (association.to_s.singularize + '_id').to_sym
        case self.reflect_on_association(association.to_s.singularize.to_sym).macro
          when :belongs_to then eval(class_name).where(id: pluck(key).uniq)
          when :has_many   then eval(class_name).where(key: pluck(:id).uniq)
        end
      end
      nil
    end
  end
end
