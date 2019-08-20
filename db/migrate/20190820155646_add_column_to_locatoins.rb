class AddColumnToLocatoins < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :good_swell_direction, :string
    add_column :locations, :good_wind_direction, :string
    add_column :locations, :swell_size, :string
    add_column :locations, :best_tide_position, :string
    add_column :locations, :best_tide_movement, :string
    add_column :locations, :webcam_url, :string
    add_column :locations, :week_crowd, :string
  end
end
