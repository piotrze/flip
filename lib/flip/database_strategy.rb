# Database backed system-wide
require 'byebug'
module Flip
  class DatabaseStrategy < AbstractStrategy
    def initialize(model_klass = Feature)
      @klass = model_klass
    end

    def description
      "Database backed, applies to all users."
    end

    def knows? definition
      !!feature(definition)
    end

    def on? definition
      enabled_now?(feature(definition))
    end

    def switchable?
      true
    end

    def partially?
      true
    end

    def switch! key, enable
      record = @klass.where(key: key.to_s).first_or_initialize
      record.enabled = enable
      record.save!
    end

    def delete! key
      @klass.where(key: key.to_s).first.try(:destroy)
    end

    private

    def feature(definition)
      @klass.where(key: definition.key.to_s).first
    end

    def enabled_now?(feature)
      return false unless feature.enabled?

      feature.percentage.present? ? rand(100) < feature.percentage : true
    end
  end
end
