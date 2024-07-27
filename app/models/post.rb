class Post < ApplicationRecord
  # serialize :tags, Array
  belongs_to :user

  # belongs_to :user, class_name: "User", foreign_key: "author_id"
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true
  validates :tags, presence: true
  # validate :tags_format

  validates :comments, length: { maximum: 1000 }

  after_create :schedule_deletion

  private
  # def tags_format
  #   if tags.is_a?(Array)
  #     tags.each do |tag|
  #       unless tag.is_a?(String) && tag.length <= 255
  #         errors.add(:tags, "each tag must be a string with a maximum length of 255 characters")
  #       end
  #     end
  #   else
  #     errors.add(:tags, "must be an array. Current value: #{tags.inspect}")
  #   end
  # end


  # def tags_format
  #     # if tags.present?
  #     unless tags.is_a?(Array) && tags.all? { |tag| tag.is_a?(String) && tag.length < 255 }
  #       errors.add(:tags, "must be an array of strings with each string having a maximum length of 255 characters")
  #     end
  #     # end
  #   end
  # def schedule_deletion
  #   DeleteOldPostsJob.set(wait: 24.hours).perform_later(self.id)
  # end
  def schedule_deletion
    # DeletePostWorker.perform_in(2.minutes, self.id)
    DeletePostWorker.perform_in(24.hours, self.id)

    # DeletePostWorker.perform_in(24.hours, self.id)
  end
end
