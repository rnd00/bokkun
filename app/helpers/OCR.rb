module OCR
  def self.total(img_path)
    require "google/cloud/vision"
    image_annotator = Google::Cloud::Vision::ImageAnnotator.new
    file_path = img_path
    lines = []
    response = image_annotator.text_detection(image: file_path)
    response.responses.each do |res|
      res.text_annotations.each do |text |
        lines << text.description
      end
    end

    amounts = lines.select{|item| item[0] == "¥"}
    a = []

    amounts.each do |value|
      a << value.gsub(',', '')
    end
    b = []
    a.each do |value|
      b << value.scan(/\d+/).map(&:to_i)
    end
    b.sort[-2][0]
  end
end
