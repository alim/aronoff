module ImmuneResponsesHelper
  def immune_search_options
    return options_for_select [['Experiment', 'experiment'],
      ['Strain', 'strain']]
  end
end
