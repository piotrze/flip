require "rails/generators/migration"

class Flip::UpgradeGenerator < Rails::Generators::Base
  include Rails::Generators::Migration

  source_root File.expand_path("../templates", __FILE__)

  def create_migration_file
    migration_template "add_percentage_to_features.rb", "db/migrate/add_percentage_to_features.rb"

    inject_into_file 'app/models/feature.rb', after: "extend Flip::Declarable\n" do <<-'RUBY'
  validates :percentage, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 100}, allow_nil: true
      RUBY
    end
  end



  def self.next_migration_number(dirname)
    Time.now.utc.strftime("%Y%m%d%H%M%S")
  end
end
