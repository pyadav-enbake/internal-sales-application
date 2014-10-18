desc 'Kitchen should be capitalized KITCHEN'
task capitalized_Kitchen: :environment do
  cabinet_type = Rcadmin::Category.find_by_name('Kitchen').update_attributes(:name => 'KITCHEN', :description => 'KITCHEN')
	puts "Kitchen Update successfully"
end
