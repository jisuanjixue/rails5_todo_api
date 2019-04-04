class TodoSerializer < ActiveModel::Serializer
  # 属性序列化
  attributes :id, :title, :created_by, :created_at, :updated_at
  # model关联
  has_many :items
end
