module Concerns::Storage
    module ClassMethods
        # def self.all
        #     @@all
        # end
    
        def self.destroy_all
            self.class.all.clear
        end
    
    end

    module InstanceMethods
        def save
            self.class.all << self
        end
    end

end