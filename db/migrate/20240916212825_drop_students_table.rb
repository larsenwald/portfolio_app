class DropStudentsTable < ActiveRecord::Migration[7.1]
  def up
    drop_table :students
  end

  def down
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.string :school_email
      t.string :major
      t.date :expected_graduation_date

      t.timestamps
    end
  end
end
