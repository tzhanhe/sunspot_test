class Production < ActiveRecord::Base
  has_many :orders
	searchable do
		text :content, :name,:title
    text :orders do
    orders.map {|order| order.desc}
    end
	end
end
