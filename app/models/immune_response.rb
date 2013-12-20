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

  # Include shared instance methods
  include SharedInstanceMethods

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
  CELL_TYPE={
    'THP1'          => THP1,
    'PM'            => PM,
    'DM term'       => DM_TERM,
    'Blood Mono'    => BLOOD_MONO,
    'T-HESC'        => T_HESC,
    'Choriodecidua' => CHORIODECIDUA,
    'Amnion Epith'  => AMNION_EPITH
  }

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
  MODEL_OPTIONS={
    'None'                => NO_MODEL,
    'Transwell'           => TRANSWELL,
    'Whole punches'       => WHOLE_PUNCHES,
    'CD punches'          => CD_PUNCHES,
    'Amnion E pith Cells' => AE_CELLS,
    'T-HESC'              => T_HESC_MODEL,
  }

  # COMPARTMENT OPTIONS
  NO_COMPARTMENT = 1
  CHORION = 2
  AMNION = 3

  # An array of hash entries that specify the different types of
  # compartments. This array can be used in views for generate selection
  # options
  COMP_OPTIONS={
    'None'    => NO_COMPARTMENT,
    'Chorion' => CHORION,
    'Amnion'  => AMNION,
  }

  # STRAIN_STATUS OPTIONS
  NO_STRAIN_STATUS = 1
  LIVE = 2
  HEAT_KILLED = 3

  # An array of hash entries that specify the different types of
  # compartments. This array can be used in views for generate selection
  # options
  STRAIN_STATUS_OPTIONS={
    'None'        => NO_STRAIN_STATUS,
    'Live'        => LIVE,
    'Heat Killed' => HEAT_KILLED,
  }

  # TREATMENT OPTIONS
  NO_TREATEMENT = 1
  PGE2 = 2
  LTB4 = 3
  LPS = 4
  LTA = 5

  # An array of hash entries that specify the different types of
  # treatments. This array can be used in views for generate selection
  # options
  TREATMENT_OPTIONS={
    'None'  => NO_TREATEMENT,
    'PGE2'  => PGE2,
    'LTB4'  => LTB4,
    'LPS'   => LPS,
    'LTA'   => LTA,
  }

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
  CYTO_OPTIONS={
    'HBD2' => HBD2,
    'IL1b' => IL1B,
    'IL1a' => IL1A,
    'IL6' => IL6,
    'IL10' => IL10,
    'IL17' => IL17,
    'TNFa' => TNFA,
    'IL8' => IL8,
    'IL12' => IL12,
  }

  # UNIT OPTIONS
  PG_ML = 1
  NG_ML = 2
  MG_ML = 3
  UG_ML = 4

  # An array of hash entries that specify the different types of
  # unit options. This array can be used in views for generate selection
  # options
  UNIT_OPTIONS={
    'pg/mL' => PG_ML,
    'ng/mL' => NG_ML,
    'mg/mL' => MG_ML,
    'ug/mL' => UG_ML,
  }

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

  scope :by_strain, ->(strain){ where(strain_name: /#{strain}/i).order_by([[:strain_name, :asc]]) }
  scope :by_experiment, ->(eid){ where(experiment_id: /#{eid}/i).order_by([[:experiment_id, :asc]]) }

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
    return attribute_str(CELL_TYPE, cell_type)
  end

  ######################################################################
  # The model_str method is a helper method to print the human
  # readable string of the model option value.
  ######################################################################
  def model_str
    return attribute_str(MODEL_OPTIONS, model)
  end

  ######################################################################
  # The compartment_str method is a helper method to print the human
  # readable string of the compartment option value.
  ######################################################################
  def compartment_str
    return attribute_str(COMP_OPTIONS, compartment)
  end

  ######################################################################
  # The strain_status method is a helper method to print the human
  # readable string of the strain status option value.
  ######################################################################
  def strain_status_str
    return attribute_str(STRAIN_STATUS_OPTIONS, strain_status)
  end

  ######################################################################
  # The treatment method is a helper method to print the human
  # readable string of the treamtment option value.
  ######################################################################
  def treatment_str
    return attribute_str(TREATMENT_OPTIONS, treatment)
  end

  ######################################################################
  # The units_str method is a helper method to print the human
  # readable string of the units option value.
  ######################################################################
  def units_str
    return attribute_str(UNIT_OPTIONS, units)
  end

  ######################################################################
  # The cyto_chemo_kine_str method is a helper method to print the human
  # readable string of the cyto_chemo_kine option value.
  ######################################################################
  def cyto_chemo_kine_str
    return attribute_str(CYTO_OPTIONS, cyto_chemo_kine)
  end

end
