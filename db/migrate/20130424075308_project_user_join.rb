class ProjectUserJoin < ActiveRecord::Migration
  def change
    create_table :projects_users, :force => true, :id => :false do |t|
      t.references :project
      t.references :user
      t.timestamps
    end
  end
end
