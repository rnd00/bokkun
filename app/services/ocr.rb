class OCR
  def self.total(img_path)
    require "google/cloud/vision"
    image_annotator = Google::Cloud::Vision::ImageAnnotator.new
    file_path = img_path
    lines = []
    response = image_annotator.document_text_detection(image: file_path)
    response.responses.each do |res|
      res.text_annotations.each do |text |
        lines << text.description
      end
    end
    lines
  end
  def self.total_amount(array)
    amounts = array.select{|item| item[0] == "¥"}
    a = []

    amounts.each do |value|
      a << value.gsub(',', '')
    end
    b = []
    a.each do |value|
      b << value.scan(/\d+/).map(&:to_i)
    end
    return nil if b.empty?

    b[-2][0]
  end
  def self.sukiya(array)
    response = array[0].split("\n")
    x = []
    response.select.with_index do |str, index|
      if str[0] == "※"
        x << [str, response[index + 1]]
      end
    end
    y = []
    x.each do |arr|
      arr.each do|str|
        y << str.split(" ")
      end
    end

    prices = []

    prices << [y[0][1], y[1][0].gsub('¥', '').to_i]
    prices << [y[2][1], y[3][0].gsub('¥', '').to_i]
    prices << [y[4][1], y[4][2].gsub('¥', '').to_i]
    prices
  end
end
