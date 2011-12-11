class PostalLoginCodeGenerator
  class << self
    def generate(length=6)
      (1..length).to_a.inject("") { |str, i| str + random_char_for_code }
    end

    private

    def random_char_for_code
      valid_chars_for_code[rand(valid_chars_for_code.size-1)]
    end

    def valid_chars_for_code
      ("1".."9").to_a + %w{A B C D E G H K M N P Q S T U W X Y Z}
    end
  end
end