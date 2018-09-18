class FooterSection::Create < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(FooterSection, :new)
    step Contract::Build(constant: FooterSection::Contract::Create)
  end

  step Nested(Present)
  success :nil_content_to_empty_str
  success :convert_to_html
  
  step Policy::Pundit(FooterSectionPolicy, :create?)
  step Contract::Validate(key: :footer_section)
  step Contract::Persist()

  def nil_content_to_empty_str(options, params:, **)
    if params[:footer_section]
      if params[:footer_section][:content] == nil
        params[:footer_section][:content] = ""
      end
    end
  end

  def convert_to_html(options, params:, **)
    if params.fetch(:footer_section, {}).fetch(:content, false)
      if params[:footer_section][:content]
        html = Convert.to_html(params[:footer_section][:content])
        params[:footer_section][:content] = html
      end
    end
  end
end
