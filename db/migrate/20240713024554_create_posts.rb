class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false
      t.string :title,  null: false, default: ''
      t.text :body, null: false, default: ''
      t.boolean :public, null: false, default: false

      t.timestamps
    end
  end
end
