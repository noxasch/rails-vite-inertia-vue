class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.references :user
      t.string :title,  null: false, default: ''
      t.text :body, null: false, default: ''

      t.timestamps
    end
  end
end
