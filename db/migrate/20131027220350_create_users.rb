class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :twitterName
      t.date :joinDate

      t.timestamps
    end
  end
end
