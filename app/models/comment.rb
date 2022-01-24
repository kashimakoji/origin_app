class Comment < ApplicationRecord
  belongs_to :user
  validates :content, length: { maximum: 255, message: 'は255文字以内で登録してください' }
end
