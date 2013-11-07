class Macrophage
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  # Add call to strip leading and trailing white spaces from all atributes
  strip_attributes  # See strip_attributes for more information
  
  ## CONSTANTS ---------------------------------------------------------
  
  # MACROPHAGE TYPES
  THP1 = 1
  PM = 2
  DM1ST = 3
  DMTERM = 4
  BLOOD_MONO = 5
  
  # An array of hash entries that specify the different types of 
  # macrophages.
  MAC_TYPE=[
    {label: 'THP1', id: THP1 },
    {label: 'PM', id: PM},
    {label: 'DM 1st Tri', id: DM1ST },
    {label: 'DM term', id: DMTERM},
    {label: 'Blood Mono', id: BLOOD_MONO}
  ]

  # TREATMENTS
  NONE = 1
  PGE2 = 2
  LTB4 = 3
  
  # An array of hash entries that specify treat choices
  TREATMENTS = [
    {label: 'None', id: NONE},
    {label: 'PGE2', id: PGE2},
    {label: 'LTB4', id: LTB4}
  ]

  # Dose measures
  Zero_uM = 1 
  PointOne_uM = 2
  One_uM = 3
  Ten_uM = 4
  
  # Dosage Array - hash enteries that specify dosage levels
  DOSEAGES = [
    {label: '0 um', id: Zero_uM},
    {label: '0.1 um', id: PointOne_uM },
    {label: '1 um', id: One_uM},
    {label: '10 um', id: Ten_uM}
  ] 

  # Data types
  NUM_PER_THP1_CELL = 1
  NOMALIZED_PHAGO_ACTIVITY = 2

  # Data type array - hash entries for data type labels and values
  DATATYPES = [
    {label: '# per THP1 cell', id: NUM_PER_THP1_CELL},
    {label: 'Normalized phago activity', id: NOMALIZED_PHAGO_ACTIVITY}
  ]
  

  ## ATTRIBUTES --------------------------------------------------------
  
  field :strain_name, type: String
  field :experiment_id, type: String
  field :macrophage_type, type: Integer
  field :treatment, type: Integer
  field :dose, type: Integer
  field :data, type: Float
  field :data_type, type: Integer
  
  ## RELATIONSHIPS -----------------------------------------------------
  
  belongs_to :user
  belongs_to :project
  
  ## INSTANCE METHODS --------------------------------------------------
  
  def macrophage_type_str
    case macrophage_type
    when THP1
      str = 'THP1'
    when PM
      str = 'PM'
    when DM1ST
      str = 'DM 1st Tri'
    when DMTERM
      str = 'DM Term'
    when BLOOD_MONO
      str = 'Blood Mono'
    else
      str = 'Unknown'
    end
    return str
  end
  
  def treatment_str
    case treatment
    when NONE
      str = 'None'
    when PGE2
      str = 'PGE2'
    when LTB4
      str = 'LTB4'
    else
      str = 'Unknown'
    end
    return str
  end
  
  def dosage_str
    case dose
    when Zero_uM
      str = '0 um'
    when PointOne_uM
      str = '0.1 um'
    when One_uM
      str = '1 um'
    when Ten_uM
      str = '10 um'
    else
      str = 'Unknown'
    end
    return str
  end
end
