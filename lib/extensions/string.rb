# String class extensions
class String
  def underscore
    word = dup
    word.gsub!(/::/, '/')
    word.gsub!(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
    word.gsub!(/([a-z\d])([A-Z])/, '\1_\2')
    word.tr!('-', '_')
    word.downcase!
    word
  end

  def indent_lines(chars_count)
    gsub(/([^\n]*)(\n|$)/) do |match|
      line = ''
      line += (' ' * chars_count) unless match == ''
      line += match
      line
    end
  end
end
