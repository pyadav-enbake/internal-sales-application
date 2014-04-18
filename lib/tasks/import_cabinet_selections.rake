desc 'Import Cabinets Selections types'
task import_cabinet_selections: :environment do

  CSV.open( Rails.root.join("lib/tasks/cabinet-selections.csv"), headers: true).each do |row|
    cabinet_type = CabinetType.find_or_initialize_by(name: row['Attribute'])
    names = row['Data'].to_s.split(",").map(&:strip).select(&:presence)
    names.map { |name| cabinet_type.selections.find_or_initialize_by(name: name) }
    cabinet_type.save!
  end
end
