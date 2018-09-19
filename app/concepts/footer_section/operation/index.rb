class FooterSection::Index < Trailblazer::Operation

  step :model
  
  def model(options, *)
    options[:model] = ::FooterSection.order(:position)
  end
end
