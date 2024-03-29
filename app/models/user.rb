class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  has_many :drive_records, dependent: :destroy
  has_many :visited_destinations, through: :drive_records, source: :destination
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_destinations, through: :bookmarks, source: :destination

  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password, format: {
    with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i,
    message: 'は英数字の混合である必要があります'
  }, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, format: {
    with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i,
    message: 'は英数字の混合である必要があります'
  }, if: -> { new_record? || changes[:crypted_password] }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :name, presence: true, length: { maximum: 50 }
  validates :reset_password_token, presence: true, uniqueness: true, allow_nil: true

  # ブックマークを作成するbookmarkメソッドは、対象となるDestinationレコードの特定と併せて一連の処理として実行するため、app/services/log_destination_activity_service.rbで定義している。
  # ブックマークの対象となる場所のデータは、DBから取得して表示しているものではなく単にAPIからのレスポンスを表示しているものであるため、「対象となる場所に該当するDestinationレコードが存在すればそれを指定し、存在しなければ新たに作成する」という処理が必要となる。そのため、Destinationレコードの特定とブックマークの作成という一連の処理をServiceオブジェクトとしてまとめて実装する方針をとっている。

  def unbookmark(destination)
    bookmark_destinations.destroy(destination)
  end

  def bookmark?(destination)
    bookmark_destinations.include?(destination)
  end
end
