class UserSelectionForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  attr_reader :drive_time_options
  
  attribute :type, :string
  attribute :feeling, :string
  attribute :drive_time, :integer

  with_options presence: true do
    validates :type
    validates :feeling
    validates :drive_time
  end

  def initialize(attributes = {})
    super(attributes)
    # 走行時間と走行距離の組み合わせは開発段階で変更する可能性があるため、現状では変数として定義している。キーとバリューの組み合わせが固まって更新不要になったら、定数として定義し直す。
    @drive_time_options = {
      '15分〜30分' => 14000,
      '30分〜1時間' => 28000,
      '1時間〜1.5時間' => 42000,
      '1.5時間〜2時間' => 56000,
      '2時間〜2.5時間' => 70000
    }
  end

  # 定数として定義し直す際は、上記のinitializeメソッドを削除して以下のコメントアウトを外す。
  #  DRIVE_TIME_OPTIONS = {
  #    '15分〜30分' => 14,
  #    '30分〜1時間' => 28,
  #    '1時間〜1.5時間' => 42,
  #    '1.5時間〜2時間' => 56,
  #    '2時間〜2.5時間' => 70
  #  }.freeze
end