class Equipment < ActiveRecord::Base
  self.table_name = 'dbo.V_EQUIPMENT'
  self.primary_key = 'EquipmentCode'
end
