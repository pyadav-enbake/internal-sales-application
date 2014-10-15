desc 'Delete Doorstyle Selections'
task delete_doorstyle_selections: :environment do
  cabinet_type = CabinetType.find_by_name(' Doorstyle Selections')
  if cabinet_type.present?
    cabinet_type.selections.delete_all
    cabinet_type.delete
    puts "Successfully Delete Doorstyle Selection"
  end
  Rcadmin::Quote.delete_all
  
end
