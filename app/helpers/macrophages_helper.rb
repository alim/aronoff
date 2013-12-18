########################################################################
# The MacrophagesHelper module holds methods used to facilitate the
# views for the Macrophages resource.
########################################################################
module MacrophagesHelper

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


  ######################################################################
  # The dosage_options method generates a selection list of dosage
  # options to be used in views.
  ######################################################################
  def dosage_options
    doptions = []
    Macrophage::DOSAGE_OPTIONS.each do |label, id|
      doptions << [label, id]
    end
    return doptions
  end


  ######################################################################
  # The macrophage_options method generates a selection list of macro-
  # phage type options to be used in views.
  ######################################################################
  def macrophage_options
    options = []
    Macrophage::MAC_TYPE.each do |label, id|
      options << [label, id]
    end
    return options
  end

  ######################################################################
  # View helper for generating treatment type options.
  ######################################################################
  def treatment_options
    options = []
    Macrophage::TREATMENTS.each do |label, id|
      options << [label, id]
    end
    return options
  end

  ######################################################################
  # View helper for generating datatype type options.
  ######################################################################
  def datatype_options
    options = []
    Macrophage::DATATYPES.each do |label, id|
      options << [label, id]
    end
    return options
  end
end
