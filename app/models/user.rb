class User < ApplicationRecord
  validates :mail, presence: {:message => "Es necesario el mail del usuario"}
  validates :image, presence: {:message => "Es necesaria la imagen para el control biométrico"}

  def self.image_capture(uploaded_io)
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
    read_img = open("./public/uploads/#{uploaded_io.original_filename}") {|f| f.read}
    file_contents = Base64.strict_encode64(read_img)
    file_contents
  end

  def self.verify_string_images(storage, post)
    length = [storage.size, post.size].max
    same = storage.each_char.zip(post.each_char).select { |origin, request| origin == request}.size
    percent = ((length - same) / storage.size.to_f).round(2)
    percent
  end
end
