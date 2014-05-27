desc 'Import Cabinets Selections types'
task import_cabinet_selections: :environment do

  CSV.open( Rails.root.join("lib/tasks/cabinets-abbr.csv"), headers: true).each do |row|
    cabinet_type = CabinetType.find_or_initialize_by(name: row['Attribute'])
    names = row['Data'].to_s.split(",").map(&:strip).select(&:presence)
    abbrs = row['Abbr'].to_s.split(",").map(&:strip).select(&:presence)
    names.each_with_index do |name, index|
      selection = cabinet_type.selections.find_or_create_by(name: name)
      selection.update_column(:abbr, abbrs[index])
    end
    cabinet_type.save!
  end
end
