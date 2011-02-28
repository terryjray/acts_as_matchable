module ActsAsMatchable
  def self.included(base)
    base.send :extend, ActsAsMatchable::ClassMethods
  end

  module ClassMethods
    def acts_as_matchable(*args)
      cattr_accessor :matchable_fields
      self.matchable_fields = (args.length == 0 || (args.length == 1 && args.first.to_s == "all")) ? :all : args
      self.send :include, ActsAsMatchable::InstanceMethods
    end
  end

  module InstanceMethods

    # returns a hash of matched cols or nil if no matches
    def pattern_match(regex)

      matches = {}
      self.class.columns.each do |col|
        if col.text? && !self[col.name].blank? &&
            (self.matchable_fields.to_s == "all" ||
              self.matchable_fields.collect{|mf| mf.to_s}.include?(col.name))
          val = eval "self.#{col.name}"
          matches[col.name] = val if val.match(regex)
        end
      end

      matches.empty? ? nil : matches
    end

  end
end

ActiveRecord::Base.send :include, ActsAsMatchable

