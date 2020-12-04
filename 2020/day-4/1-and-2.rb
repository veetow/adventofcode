require_relative 'passport'

data = []
passport = nil
present = 0
valid = 0

IO.foreach('input') do |line|
  line = line.chomp.strip
  if line == "" then
    passport = Passport.new(raw: data)
    present += 1 if passport.present?
    valid += 1 if passport.valid?

    data = []
  else
    data << line
  end
end

passport = Passport.new(raw: data)
present += 1 if passport.present?
valid += 1 if passport.valid?

puts present
puts valid
