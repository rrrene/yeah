class Yeah::Surface
  attr_reader :size
  attr_accessor :data

  def initialize(size)
    self.size = size
  end

  def size=(value)
    @size = value
    @data = "\x00" * 4 * size.x * size.y
  end

  def color_at(position)
    data_lines = data.scan(/.{#{size.x*4}}/)
    line = data_lines[position.y]
    color_string = line[position.x*4..position.x*4+3]
    color_bytes = color_string.unpack('H*')[0].
      scan(/.{2}/).map { |b| b.to_i(16) }
    Color[*color_bytes]
  end

  def fill_rectangle(position1, position2, color)
    puts position1.inspect
    puts position2.inspect
    color_byte_string = color.rgba_bytes.pack('C*')
    data_lines = data.scan(/.{#{size.x*4}}/)

    rect_width = (position2.x - position1.x).abs
    (position1.y...position2.y).each do |i|
      line = data_lines[i]
      color_bytes_row = color_byte_string * rect_width
      line[position1.x*4...position2.x*4] = color_bytes_row
    end

    print "\n"
    data_lines.each do |line|
      line.scan(/.{4}/).each do |pixel|
        rep = (pixel.bytes == [0, 0, 0, 0]) ? 0 : 1
        print rep
      end
      print "\n"
    end

    @data = data_lines.join
  end
end
