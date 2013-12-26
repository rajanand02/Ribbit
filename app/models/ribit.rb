class Ribit < ActiveRecord::Base
  attr_accessible :content, :uer_id
  default_scope order: "created_at DESC"

  validates :content, length: { maximum: 140}
end
