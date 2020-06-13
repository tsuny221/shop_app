class Good < ActiveRecord::Base

	has_many :line_items
	before_destroy :referenced_by_line_item

	validate :price_validate

	#Railsで標準で用意されている検証メソッド
	#指定されたフィールドが存在し、その内容が空でないことを確認。
	validates_presence_of :title, :image_url, :maker, :category,
	:message => "が空の状態で保存することは出来ません。"

	#priceフィールドに数字か入力されているか検証。
	validates_numericality_of :price,
	:message => "が有効な数値ではありません。"

	#titleフィールドに保存しようとする名称が存在していないかどうかを確認。
	validates_uniqueness_of :title,
	:message => "はすでに存在しています。"

	#フィールドの値が正規表現に一致するかどうかをチェック。
	#.gif,.jpg,.pngのどれかで終わっていることを確認。
	validates_format_of :image_url,
	:with => /\a|\.jpg$|\.png$|\.gif$\z/,
	:message => "はGIF,JPG,PNG画像でなければなりません。"

	#商品の価格が正の数であることを確認する。
	#価格フィールドが空でないときだけチェックをする。
	protected
	def price_validate
		errors.add(:price, "は0より大きくなければなりません。") unless price.nil? || price > 0.0
	end

	def self.select_shop
		where("date <= ?","now()").order(title: "ASC")
	end

	private
	def referenced_by_line_item

		if line_items.empty?
			return true
		else
			errors.add(:base, '品目が存在します。')
			retuen false
		end
	end

end