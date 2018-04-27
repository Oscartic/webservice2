class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :mail
      t.text :image
      t.inet :current_sign_in_ip
    end
  end
end
