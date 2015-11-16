class Feature < ActiveRecord::Base
  extend Flip::Declarable

  validates :percentage, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 100}, allow_nil: true

  strategy Flip::CookieStrategy
  strategy Flip::DatabaseStrategy
  strategy Flip::DeclarationStrategy
  default false

  # Declare your features here, e.g:
  #
  # feature :world_domination,
  #   default: true,
  #   description: "Take over the world."
end
