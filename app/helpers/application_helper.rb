module ApplicationHelper
  #####################################################################
  # The active method is a helper function that returns "active" or
  # empty string. It is used to set a CSS class to active for
  # highlighting the active menu item.
  #####################################################################
  def active(path)
    if (path == home_index_path && request.fullpath == '/') ||
       (path == '/settings' && (request.fullpath =~ /^\/group/).present?) ||
       (path == '/settings' && (request.fullpath =~ /^\/project/).present?) ||
       (path == '/settings' && (request.fullpath =~ /^\/users\/edit/).present?) ||
        request.fullpath =~ /^#{path}/
      'active'
    end
  end

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
  # The tag_options method returns an option_for_select object for
  # all the tags currently in the system or associated with the object
  # that is passed as the optional parameter.
  #####################################################################
  def tag_options_list(tagged_object=nil)
    tag_list = tag_options = []
    tag_list = Macrophage.tags + ImmuneResponse.tags
    tag_list.uniq!.sort!
    tag_list.each do |tag|
      tag_options << [tag, tag]
    end
    selected_tags = tagged_object.tags.split(',') if tagged_object && tagged_object.tags.present?
    return options_for_select(tag_options, selected_tags)
  end

  #####################################################################
  # The tag_labels helper method will take an array of tag
  # strings and return HTML code that wraps the elements
  # in button CSS code.
  #####################################################################
  def tag_labels(tags)
    html = ''
    if tags.present?
      tags.each do |tag|
        html += "<span class='label'>" + tag + "</span>&nbsp;"
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
