class Export
  def self.to_xls(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |element|
        csv << element.attributes.values_at(*column_names)
      end
    end
  end
end
