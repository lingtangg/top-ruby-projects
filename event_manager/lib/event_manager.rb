require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

def clean_zipcode(zipcode)
  # if zipcode.nil?
  #   zipcode = '00000'
  # elsif zipcode.length < 5
  #   zipcope = zipcode.rjust(5, '0')
  # elsif zipcode.length > 5
  #   zipcode = zipcode[0..4]
  # else
  #   zipcode
  # end

  # Can be simplified to
  zipcode.to_s.rjust(5, '0')[0..4]
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zipcode,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials

    # legislator_names = legislators.map do |legislator|
    #   legislator.name
    # end
    # simplified to
    # legislator_names = legislators.map(&:name)
    # legislators_string = legislator_names.join(", ")
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exists?('output')
  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    # here, puts writes to the file
    file.puts form_letter
  end
end

def clean_phone_number(raw_number)
  phone_number = raw_number.gsub("-", "")
  if phone_number.length < 10 || phone_number.length > 11
    phone_number = "bad"
  elsif phone_number.length == 11
    if phone_number[0] == '1'
      phone_number = phone_number[1..-1]
    else
      phone_number = "bad"
    end
  else
    phone_number
  end
end

def most_popular_hour(regdate, hash)
  hour = regdate[-5..-4].to_i
  hash[hour] += 1
end

def most_popular_day(regdate, hash)
  day = regdate[0..7]
  if day[1] == '/'
    day = day[0..6].strip.rjust(7, '0')
  end
  if day[-5] == '/'
    day = day.insert(-5, "0")
  end
  day = day.insert(-3, "20")
  hash[Date.strptime(day, "%m/%d/%Y").strftime("%A")] += 1
end

puts 'Event Manager Initialised!'

# Manual CSV parser
# if File.exist? "event_attendees.csv" then lines = File.readlines('event_attendees.csv') end
# lines.each_with_index do |line, index|
#   next if index == 0
#   columns = line.split(",")
#   name = columns[2]
#   puts name
# end

# Ruby's CSV parser
contents = CSV.open(
  'event_attendees.csv', 
  headers: true,
  header_converters: :symbol)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

reg_times = Hash.new(0)
reg_days = Hash.new(0)

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letter(id, form_letter)

  phone_number = clean_phone_number(row[:homephone])

  popular_hour = most_popular_hour(row[:regdate], reg_times)

  popular_day = most_popular_day(row[:regdate], reg_days)
end