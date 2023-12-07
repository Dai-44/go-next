class SetRequestParamsForm
  include ActiveModel::Model
  include ActiveModel::Attributes 
  
  attribute :type, :string
  attribute :feeling, :string

  with_options presence: true do
    validates :type
    validates :feeling
  end
end