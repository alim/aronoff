########################################################################
# The MacrophagesHelper module holds methods used to facilitate the
# views for the Macrophages resource.
########################################################################
module MacrophagesHelper
  
  ######################################################################
  # The dosage_options method generates a selection list of dosage
  # options to be used in views.
  ######################################################################
  def dosage_options
    doptions = []
    Macrophage::DOSEAGES.each do |dosage|
      doptions << [dosage[:label], dosage[:id]]
    end
    return doptions
  end
  
 
  ######################################################################
  # The macrophage_options method generates a selection list of macro-
  # phage type options to be used in views.
  ######################################################################
  def macrophage_options
    options = []
    Macrophage::MAC_TYPE.each do |mtype|
      options << [mtype[:label], mtype[:id]]
    end
    return options
  end 
  
  ######################################################################
  # View helper for generating treatment type options.
  ######################################################################
  def treatment_options
    options = []
    Macrophage::TREATMENTS.each do |treatment|
      options << [treatment[:label], treatment[:id]]
    end
    return options
  end
  
  ######################################################################
  # View helper for generating datatype type options.
  ######################################################################
  def datatype_options
    options = []
    Macrophage::DATATYPES.each do |data_type|
      options << [data_type[:label], data_type[:id]]
    end
    return options
  end  
  
  ######################################################################
  # View helper to generate a list of the current user's projects
  ######################################################################
  def project_list
    options = []
    @projects.each do |project|
      options << [project.name, project.id]
    end
    return options
  end
end
