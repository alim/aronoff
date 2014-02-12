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

  ######################################################################
  # The strain_name_options method is designed to provide a list of
  # GBS strain names for the view. In the future, this list will be
  # pulled from the MLST system using ActiveResource.
  ######################################################################
  def strain_name_options
    gbs_strains = [
      'A909', 'GB1007', 'GB112', 'GB115', 'GB12', 'GB13',
      'GB1455', 'GB1459', 'GB2', 'GB20', 'GB241',
      'GB279', 'GB285', 'GB291', 'GB310', 'GB33',
      'GB36', 'GB362', 'GB37', 'GB374', 'GB377', 'GB390',
      'GB397', 'GB411', 'GB418', 'GB438', 'GB45', 'GB555',
      'GB557', 'GB561', 'GB571', 'GB590', 'GB64', 'GB651',
      'GB653', 'GB654', 'GB66', 'GB663', 'GB686', 'GB69',
      'GB79', 'GB83', 'GB84', 'GB910', 'GB92', 'GB97',
      'NEM316'
    ]

    options = []
    gbs_strains.each do |strain|
      options << [strain, strain]
    end
    return options
  end  

  #####################################################################
  # The tag_buttons helper method will take an array of tag
  # strings and return HTML code that wraps the elements
  # in button CSS code.
  #####################################################################
  def tag_buttons(tags)
    html = ''
    if tags.present?
      tags.each do |tag|
        html += "<span class='btn btn-mini btn-inverse'>" + tag + "</span>&nbsp;"
      end
    end
    html.html_safe
  end  

  #####################################################################
  # The value_or_none helper method will print the value or a None
  # string followed by a <br/> html code. The method returns html_safe
  # string.
  #####################################################################
  def value_or_none(value)
    html = ''
    if value.present?
      html += value
    else
      html += 'None<br/>'
    end
    html.html_safe
  end

end
