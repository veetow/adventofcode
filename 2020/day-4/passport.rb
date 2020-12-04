class Passport
  BIRTH_YEAR      = 'byr'.freeze
  EXPIRATION_YEAR = 'eyr'.freeze
  EYE_COLOR       = 'ecl'.freeze
  HAIR_COLOR      = 'hcl'.freeze
  HEIGHT          = 'hgt'.freeze
  ISSUE_YEAR      = 'iyr'.freeze
  PASSPORT_ID     = 'pid'.freeze

  # optional
  COUNTRY_ID = 'cid'.freeze

  VALID_EYE_COLORS = %w(amb blu brn gry grn hzl oth)

  attr_reader :birth_year
  attr_reader :expiration_year
  attr_reader :eye_color
  attr_reader :hair_color
  attr_reader :height
  attr_reader :issue_year
  attr_reader :passport_id
  attr_reader :country_id

  def initialize(raw: [])
    raw.join(" ").strip.split.each do |r|
      k,v = r.split(":")
      case k
      when BIRTH_YEAR
        @birth_year = v.to_i
      when EXPIRATION_YEAR
        @expiration_year = v.to_i
      when EYE_COLOR
        @eye_color = v
      when HAIR_COLOR
        @hair_color = v
      when HEIGHT
        @height = v
      when ISSUE_YEAR
        @issue_year = v.to_i
      when PASSPORT_ID
        @passport_id = v
      when COUNTRY_ID
        @country_id = v
      end
    end
  end

  def present?
    birth_year && expiration_year && eye_color && hair_color && height && issue_year && passport_id
  end

  def valid?
    present? &&
      valid_birth_year? && 
      valid_expiration_year? &&
      valid_eye_color? &&
      valid_hair_color? &&
      valid_height? &&
      valid_issue_year? &&
      valid_passport_id?
  end

  def valid_birth_year?
    birth_year >= 1920 && birth_year <= 2002
  end

  def valid_expiration_year?
    expiration_year >= 2020 && expiration_year <= 2030
  end

  def valid_eye_color?
    VALID_EYE_COLORS.include? eye_color
  end

  def valid_hair_color?
    hair_color.match(/^\#[0-9a-f]{6}/)
  end

  def valid_height?
    m = height.match(/^([0-9]+)(cm|in)$/)
    return false unless m

    value = m[1].to_i
    unit  = m[2]

    if unit == "cm" then
      return value >= 150 && value <= 193
    else
      return value >= 59 && value <= 76
    end
  end

  def valid_issue_year?
    issue_year >= 2010 && issue_year <= 2020
  end

  def valid_passport_id?
    passport_id.match?(/^[0-9]{9}$/)
  end
end
