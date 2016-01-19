class Atbash
  def self.encode(msg)
    tools = AtbashTool.new(msg)
    tools.encode_engine
    tools.encoded_msg
  end
end

class AtbashTool
  attr_reader :msg, :encoded_msg, :characters

  def initialize(msg)
    @msg = msg
    @encoded_msg = ''
    @characters = []
  end

  def encode_engine
    remove_invalid_chars
    build_characters
    encode_characters
    blocks_of_five
  end

  private

  def remove_invalid_chars
    msg.gsub!(/\W*/, '')
  end

  def build_characters
    msg.split(//).each { |char| characters << Character.new(char) }
  end

  def encode_characters
    characters.each do |char|
      if char.number?
        encoded_msg << char.value
      else
        encoded_msg << char.encoded_letter
      end
    end
  end

  def blocks_of_five
    @encoded_msg = encoded_msg.scan(/.{1,5}/).join(' ')
  end
end

class Character
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def number?
    value =~ /\d/
  end

  def encoded_letter
    cipher[value.downcase.to_sym]
  end

  private

  def cipher
    { a: 'z', b: 'y', c: 'x', d: 'w', e: 'v', f: 'u', g: 't', h: 's', i: 'r',
      j: 'q', k: 'p', l: 'o', m: 'n', n: 'm', o: 'l', p: 'k', q: 'j', r: 'i',
      s: 'h', t: 'g', u: 'f', v: 'e', w: 'd', x: 'c', y: 'b', z: 'a' }
  end
end
