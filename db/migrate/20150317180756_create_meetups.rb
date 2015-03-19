class CreateMeetups < ActiveRecord::Migration
  def change
    create_table :meetups do |t|
      t.string :name, null: false
      t.string :description
      t.string :location, null: false
    end
  end
end
