class FooterSection::Destroy < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(FooterSection, :find_by)
  end

  step Nested(Present)
  step Policy::Pundit(FooterSectionPolicy, :destroy?, name: "destroying")
  step :delete

  def delete(options, model:, **)
    model.destroy
  end
end
