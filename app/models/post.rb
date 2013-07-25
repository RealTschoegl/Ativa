class Post < ActiveRecord::Base
  attr_accessible :attachment, :message, :title, :phase_id, :project_id
  belongs_to :project
  belongs_to :phase

  default_scope order('created_at DESC')

  mount_uploader :attachment, ImageUploader

  def snippet
    message_size = 90 + rand(150)
    snippet = self.message.truncate(message_size, :separator => ' ')
    return snippet
  end

  def image_url(size)
    if self.attachment_url == /^https:\/\/ativa-attachments-2.s3-us-west-2.amazonaws.com\/uploads.+http/
      return self.attachment_url(size)
    else
      hyperlink = /http.+/.match(self.attachment_url.gsub("https://ativa-attachments-2.s3.amazonaws.com", "")).to_s.gsub("%3A",":")
      return hyperlink
    end

  end

end


