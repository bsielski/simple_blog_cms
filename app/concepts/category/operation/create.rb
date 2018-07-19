class Category::Create < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(Category, :new)
    step Contract::Build(constant: Category::Contract::Create)
  end
  
  step Nested(Present)
  success :normalize_params
  step Policy::Pundit(CategoryPolicy, :create?)
  step Contract::Validate(key: :category)
  step Contract::Persist()

  def normalize_params(options, params:, **)
    if params.fetch(:category, {}).fetch(:name, false)
      params[:category][:name] = params[:category][:name].gsub("\t", " ").gsub("\n", " ").squeeze(" ").strip if params[:category][:name]
    end
    if params.fetch(:category, {}).fetch(:description, false)
      params[:category][:description] = params[:category][:description].gsub("\t", " ").gsub("\n", " ").squeeze(" ").strip if params[:category][:description]
    end
  end
end
