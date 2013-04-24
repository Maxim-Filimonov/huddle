class CreateStatusReports < ActiveRecord::Migration
  def change
    create_table :status_reports do |t|
      t.references :project, index: true
      t.references :user, index: true
      t.text :yesterday
      t.text :today
      t.date :status_date

      t.timestamps
    end
  end
end
