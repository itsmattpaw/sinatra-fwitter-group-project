module Slugs
    def self.included(klass)
        klass.extend(ClassMethods)
    end
    def slug
        @slug = self.username.downcase.split(" ")
        @slug = @slug.join("-")
    end

    def make_capital(str)
        @exclude = ["and", "or", "the", "over", "to", "the", "a", "but", "with"]
        str.capitalize! #capitalize first work regardless
        #starting at index 1 capitalize all words that don't fall on exclusion list
        str.map {|m| @exclude.include?(m) ? m : m.capitalize }
    end

    module ClassMethods
        def find_by_slug(slug)
            #@exclude = ["and", "or", "the", "over", "to", "the", "a", "but", "with"]
            @h = slug.split("-")#.map.with_index {|m| @exclude.include?(m) ? m : m.capitalize }
            @username = @h.join(" ")
            self.find_by(username: @username)
        end
    end
end