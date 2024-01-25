class UserSelectionForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  attr_reader :drive_time_options

  # このFormオブジェクトの各属性はGoogle Places APIへのリクエストに用いる値(及びその生成元になる値)を扱うため、予期せぬエラーを防ぐ意味でも型は固定されている方がより望ましい。
  # カスタム型のStringArrayを別途定義してtype属性の型として指定することで、type属性を配列形式に限定したかったが、実装中のエラーを解決できなかったので後に対応する。
  attribute :type
  attribute :feeling, :integer
  attribute :drive_range, :integer
  attribute :latitude, :float
  attribute :longitude, :float

  validates :feeling, presence: { message:'いまの気分を選択してください' }
  validates :drive_range, presence: { message:'どのくらい走りたいか選択してください' }
  validates :latitude, presence: { message:'現在地の緯度および経度を取得に失敗しました。お手数ですが、画面をリロードした上で再度お試しください。' }
  validates :longitude, presence: { message:'現在地の緯度および経度を取得に失敗しました。お手数ですが、画面をリロードした上で再度お試しください' }

  def initialize(attributes = {})
    super(attributes)
    # 走行時間と走行距離の組み合わせは開発段階で変更する可能性があるため、現状では変数として定義している。キーとバリューの組み合わせが固まって更新不要になったら、定数として定義し直す。
    @drive_time_options = {
      '30分以内' => 14_000,
      '1時間以内' => 28_000,
      '1.5時間以内' => 42_000
    }
  end

  # 定数として定義し直す際は、上記のinitializeメソッドを削除して以下のコメントアウトを外す。
  #  DRIVE_TIME_OPTIONS = {
  #    '15分〜30分' => 14_000,
  #    '30分〜1時間' => 28_000,
  #    '1時間〜1.5時間' => 42_000
  #  }.freeze

  # 定数を外部(viewファイルなど)から呼び出せるように、呼び出し用のメソッドも定義する。
  #   def drive_time_options
  #     DRIVE_TIME_OPTIONS.keys
  #   end

  # ユーザーの選択内容を受けてSearches#createで作成したUserSelectionFormインスタンスをもとに、ハッシュを作成。
  # 作成されたハッシュは、Google Places APIへのリクエストを実行するメソッド(SearchPlacesService.search_places)の引数となる。その形で使えるようにここで成形している。
  def to_request_params
    params_hash = {}
    params_hash[:included_types] = to_types(self.feeling) # self.feelingには、ユーザーによって選択されたFeelingインスタンスに該当する、feelingsテーブルのレコードのidが格納されている。
    params_hash[:excluded_primary_types] = self.type
    params_hash[:radius] = self.drive_range
    params_hash[:latitude] = self.latitude
    params_hash[:longitude] = self.longitude
    params_hash
  end

  private

  # feelingsテーブルのidを引数に取り、関連のあるgoogle_places_api_typesテーブルのレコードのnameカラムの値を返すメソッド。
  # Feelingは本アプリ内に限るものであり、Google Places APIへのリクエスト時にはGooglePlacesApiTypeのname属性の値(Gooogle Places APIで指定されるTypesと同じもの)へと変更する必要があるため、この変換メソッドが必要。
  # by_feelingスコープは、app/models/google_places_api_type.rbで定義している。
  def to_types(feeling_id)
    GooglePlacesApiType.by_feeling(feeling_id).pluck(:name)
  end
end
