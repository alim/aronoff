module ApplicationHelper
  ######################################################################
  # The selection_options method generates a selection list array based
  # on a hash that is pasted as the single parameter. The hash will
  # use the key as the label and value as the id.
  ######################################################################
  def selection_options(selection_hash)
    options = []
    selection_hash.each do |label, id|
      options << [label, id]
    end
    return options
  end
end
