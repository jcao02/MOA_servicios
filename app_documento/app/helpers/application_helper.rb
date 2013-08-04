module ApplicationHelper
  def wicked_pdf_image_tag(img, options={})
    if img[0].chr == "/" # images from paperclip
      new_image = img.slice 1..-1
      image_tag "file://#{Rails.root.join('public', new_image)}", options
    else
      image_tag "file://#{Rails.root.join('public', 'images', img)}", options
    end
  end
  def link_to_submit(*args, &block)
    link_to_function (block_given? ? capture(&block) : args[0]), "$(this).closest('form').submit()", args.extract_options!
  end
end
