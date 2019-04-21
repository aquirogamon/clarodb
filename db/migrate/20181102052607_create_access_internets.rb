class CreateAccessInternets < ActiveRecord::Migration
  def change
    create_table :access_internets do |t|
      t.float :total_traffic
      t.float :hfc_cgn
      t.float :hfc_public
      t.float :hfc_ipv6
      t.float :hfc
      t.float :mobile_cgn
      t.float :mobile_corporate
      t.float :mobile_ipv6
      t.float :mobile
      t.float :mobile_olo
      t.float :corporate
      t.float :cache_in

      t.timestamps null: false
    end
  end
end
