# encoding: utf-8
#
# This script is used to import discipline and URI data from TSV list.
#
# Format:
# Discipline	URI
# 	URI
# 	URI
# Discipline	URI
# 	URI
#
# Notes:
# 1. Note the \t symbols in format;
# 2. Second and third URI belongs to first discipline, fifth - to the second.

desc "Fills database with disciplines and URIs from given TSV file"
task :import, [:filename] => [:environment] do |t, args|
	filename = args[:filename]
	created = 0
	empty = 0
	repetitive = 0
	ActiveRecord::Base.transaction do
		IO.readlines(filename).each do |entry|
			next if entry.blank?
			discip, url = entry.split("\t")
			discip = /([\w\s\dА-ЯЁа-яё-]*)(\((\d+\.\d*\,?.*)+\))?/.match(discip)[1] # Use only discipline name (not speciality code, if supplied)
			discip = discip.squeeze(' ').strip
			url = url.gsub(/\s+/, '')
			puts "Inserting: " + url
			@discipline = Discipline.where(:name => discip).first_or_create! unless discip.empty?
			@address = Address.new(:url => url, :description => "Импортирован #{I18n.l Date.today, :format => :long} года для дисциплины «#{@discipline.name}»")
			@address.discipline_id = @discipline.id
			if url.empty?
				empty += 1
				next
			end
			if Address.where(:url => @address.url, :discipline_id => @discipline.id).exists?
				repetitive += 1
				next
			end
			created += 1 if @address.save!
		end
	end

	puts "Created:    #{created}"
	puts "Empty:      #{empty}"
	puts "Repetitive: #{repetitive}"
end
