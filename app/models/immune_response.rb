########################################################################
# The ImmuneResponse model holds the experimental results data from
# the immune reponse studies. It has the ability to store the original
# data file as an attachment. The model also provides several helper
# methods that and constants that restrict entry into some of the
# data fields.
########################################################################
class ImmuneResponse
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  # Shared class methods for restricted searching
  extend SharedClassMethods

  # Add call to strip leading and trailing white spaces from all atributes
  strip_attributes  # See strip_attributes for more information

  ## CALLBACKS ---------------------------------------------------------
  before_destroy :delete_file

  ## CONSTANTS ---------------------------------------------------------

  # CELL_TYPES
  THP1 = 1
  PM = 2
  DM_TERM = 3
  BLOOD_MONO = 4
  T_HESC = 5
  CHORIODECIDUA = 6
  AMNION_EPITH = 7

  # An array of hash entries that specify the different types of
  # cell types. This array can be used in views for generate selection
  # options
  CELL_TYPE=[
    {label: 'THP1', id: THP1 },
    {label: 'PM', id: PM },
    {label: 'DM term', id: DM_TERM},
    {label: 'Blood Mono', id: BLOOD_MONO },
    {label: 'T-HESC', id: T_HESC},
    {label: 'Choriodecidua', id: CHORIODECIDUA},
    {label: 'Amnion Epith', id: AMNION_EPITH}
  ]

  # MODEL OPTIONS
  NO_MODEL = 1
  TRANSWELL = 2
  WHOLE_PUNCHES = 3
  CD_PUNCHES = 4
  AE_CELLS = 5
  T_HESC_MODEL = 6


  # An array of hash entries that specify the different types of
  # models. This array can be used in views for generate selection
  # options
  MODEL_OPTIONS=[
    {label: 'None', id: NO_MODEL},
    {label: 'Transwell', id: TRANSWELL},
    {label: 'Whole punches', id: WHOLE_PUNCHES},
    {label: 'CD punches', id: CD_PUNCHES},
    {label: 'Amnion E pith Cells', id: AE_CELLS},
    {label: 'T-HESC', id: T_HESC_MODEL},
  ]

  # COMPARTMENT OPTIONS
  NO_COMPARTMENT = 1
  CHORION = 2
  AMNION = 3

  # An array of hash entries that specify the different types of
  # compartments. This array can be used in views for generate selection
  # options
  COMP_OPTIONS=[
    {label: 'None', id: NO_COMPARTMENT},
    {label: 'Chorion', id: CHORION},
    {label: 'Amnion', id: AMNION},
  ]

  # STRAIN_STATUS OPTIONS
  NO_STRAIN_STATUS = 1
  LIVE = 2
  HEAT_KILLED = 3

  # An array of hash entries that specify the different types of
  # compartments. This array can be used in views for generate selection
  # options
  STRAIN_STATUS_OPTIONS=[
    {label: 'None', id: NO_STRAIN_STATUS},
    {label: 'Live', id: LIVE},
    {label: 'Heat Killed', id: HEAT_KILLED},
  ]

  # TREATMENT OPTIONS
  NO_TREATEMENT = 1
  PGE2 = 2
  LTB4 = 3
  LPS = 4
  LTA = 5

  # An array of hash entries that specify the different types of
  # treatments. This array can be used in views for generate selection
  # options
  TREATMENT_OPTIONS=[
    {label: 'None', id: NO_TREATEMENT},
    {label: 'PGE2', id: PGE2},
    {label: 'LTB4', id: LTB4},
    {label: 'LPS', id: LPS},
    {label: 'LTA', id: LTA},
  ]

  # CYTO-CHEMO-KINE OPTIONS
  HBD2 = 1
  IL1B = 2
  IL1A = 3
  IL6 = 4
  IL10 = 5
  IL17 = 6
  TNFA = 7
  IL8 = 8
  IL12 = 9

  # An array of hash entries that specify the different types of
  # cyto-chemo-kines. This array can be used in views for generate selection
  # options
  CYTO_OPTIONS=[
    {label: 'HBD2', id: HBD2},
    {label: 'IL1b', id: IL1B},
    {label: 'IL1a', id: IL1A},
    {label: 'IL6', id: IL6},
    {label: 'IL10', id: IL10},
    {label: 'IL17', id: IL17},
    {label: 'TNFa', id: TNFA},
    {label: 'IL8', id: IL8},
    {label: 'IL12', id: IL12},
  ]

  # UNIT OPTIONS
  PG_ML = 1
  NG_ML = 2
  MG_ML = 3
  UG_ML = 4

  # An array of hash entries that specify the different types of
  # unit options. This array can be used in views for generate selection
  # options
  UNIT_OPTIONS=[
    {label: 'pg/mL', id: PG_ML},
    {label: 'ng/mL', id: NG_ML},
    {label: 'mg/mL', id: MG_ML},
    {label: 'ug/mL', id: UG_ML},
  ]

  ## ATTRIBUTES --------------------------------------------------------

  field :experiment_id, type: String
  field :strain_name, type: String
  field :cell_type, type: Integer
  field :model, type: Integer
  field :compartment, type: Integer
  field :time_point, type: String
  field :moi, type: Float
  field :strain_status, type: Integer
  field :treatment, type: Integer
  field :dose, type: Float
  field :result, type: String
  field :cyto_chemo_kine, type: Integer
  field :units, type: Integer
  field :notes, type: String

  ## VALIDATIONS -------------------------------------------------------

  validates_uniqueness_of :experiment_id
  validates_presence_of :experiment_id

  validates_presence_of :strain_name

  validates_presence_of :cell_type
  validates :cell_type, inclusion: { in: [THP1, PM, DM_TERM, BLOOD_MONO,
    T_HESC, CHORIODECIDUA, AMNION_EPITH ], message: "is invalid" }

  validates_presence_of :model
  validates :model, inclusion: { in: [NO_MODEL, TRANSWELL, WHOLE_PUNCHES,
    CD_PUNCHES, AE_CELLS, T_HESC_MODEL], message: "is invalid" }

  validates_presence_of :compartment
  validates :compartment, inclusion: { in: [NO_COMPARTMENT, CHORION,
    AMNION], message: "is invalid" }

  validates_presence_of :strain_status
  validates :strain_status, inclusion: { in: [NO_STRAIN_STATUS, LIVE,
    HEAT_KILLED], message: "is invalid" }

  validates_presence_of :treatment
  validates :treatment, inclusion: { in: [ NO_TREATEMENT, PGE2, LTB4,
    LPS, LTA], message: "is invalid" }

  validates_presence_of :result

  validates_presence_of :cyto_chemo_kine
  validates :cyto_chemo_kine, inclusion: { in: [HBD2, IL1B, IL1A, IL6,
    IL10, IL17, TNFA, IL8, IL12], message: "is invalid" }

  validates_presence_of :units
  validates :units, inclusion: { in: [PG_ML, NG_ML, MG_ML, UG_ML],
    message: "is invalid" }

  validates_presence_of :user_id

  ## INDICES -----------------------------------------------------------

  index({strain_name: 1}, {unique: true, name: "strain_index" })
  index({experiment_id: 1}, {unique: true, name: "experiment_index" })

  ## PREDEFINED SCOPES -------------------------------------------------

  scope :by_strain, ->(strain){ where(strain_name: /#{strain}/).order_by([[:strain_name, :asc]]) }
  scope :by_experiment, ->(eid){ where(experiment_id: /#{eid}/).order_by([[:experiment_id, :asc]]) }

  ## RELATIONSHIPS -----------------------------------------------------

  belongs_to :user
  belongs_to :project
  has_mongoid_attached_file :raw_datafile

  ## PUBLIC INSTANCE METHODS -------------------------------------------

  ######################################################################
  # This callback method will delete attached file, if the corresponding
  # Macrophage model object is destroyed.
  ######################################################################
  def delete_file
    self.raw_datafile = nil
    self.save
  end

  ######################################################################
  # The cell_type_str method is a helper method to print the human
  # readable string of the cell type value.
  ######################################################################
  def cell_type_str
    case cell_type
    when THP1
      str = 'THP1'
    when PM
      str = 'PM'
    when DM_TERM
      str = 'DM Term'
    when BLOOD_MONO
      str = 'Blood Mono'
    when T_HESC
      str = 'T-HESC'
    when CHORIODECIDUA
      str = 'Choriodecidua'
    when AMNION_EPITH
      str = 'Amnion Epith'
    else
      str = 'Unknown'
    end
    return str
  end

  ######################################################################
  # The model_str method is a helper method to print the human
  # readable string of the model option value.
  ######################################################################
  def model_str
    case model
    when NO_MODEL
      str = 'None'
    when TRANSWELL
      str = 'Transwell'
    when WHOLE_PUNCHES
      str = 'Whole punches'
    when CD_PUNCHES
      str = 'CD punches'
    when AE_CELLS
      str = 'Amnion E pith Cells'
    when T_HESC_MODEL
      str = 'T-HESC'
    else
      str = 'Unknown'
    end
    return str
  end

  ######################################################################
  # The compartment_str method is a helper method to print the human
  # readable string of the compartment option value.
  ######################################################################
  def compartment_str
    case compartment
    when NO_COMPARTMENT
      str = 'None'
    when CHORION
      str = 'Chorion'
    when AMNION
      str = 'Amnion'
    else
      str = 'Unknown'
    end
    return str
  end

  ######################################################################
  # The strain_status method is a helper method to print the human
  # readable string of the strain status option value.
  ######################################################################
  def strain_status_str
    case strain_status
    when NO_STRAIN_STATUS
      str = 'None'
    when LIVE
      str = 'Live'
    when HEAT_KILLED
      str = 'Heat Killed'
    else
      str = 'Unknown'
    end
    return str
  end

  ######################################################################
  # The treatment method is a helper method to print the human
  # readable string of the treamtment option value.
  ######################################################################
  def treatment_str
    case treatment
    when NO_TREATEMENT
      str = 'None'
    when PGE2
      str = 'PGE2'
    when LTB4
      str = 'LTB4'
    when LPS
      str = 'LPS'
    when LTA
      str = 'LTA'
    else
      str = 'Unknown'
    end
    return str
  end

  ######################################################################
  # The units_str method is a helper method to print the human
  # readable string of the units option value.
  ######################################################################
  def units_str
    case units
    when PG_ML
      str = 'pg/mL'
    when NG_ML
      str = 'ng/mL'
    when MG_ML
      str = 'mg/mL'
    when UG_ML
      str = 'ug/mL'
    else
      str = 'Unknown'
    end
    return str
  end

  ######################################################################
  # The cyto_chemo_kine_str method is a helper method to print the human
  # readable string of the cyto_chemo_kine option value.
  ######################################################################
  def cyto_chemo_kine_str
    case cyto_chemo_kine
    when HBD2
      str = 'HBD2'
    when IL1B
      str = 'IL1b'
    when IL1A
      str = 'IL1a'
    when IL6
      str = 'IL6'
    when IL10
      str = 'IL10'
    when IL17
      str = 'IL17'
    when TNFA
      str = 'TNFa'
    when IL8
      str = 'IL8'
    when IL12
      str = 'IL12'
    else
      str = 'Unknown'
    end
    return str
  end

end
