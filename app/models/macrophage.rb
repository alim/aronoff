########################################################################
# The Macrophage model class is used to respresent the data storage
# for macrophage expirements. The model is designed to hold the
# results of the experiment, not all the detailed experimental data.
########################################################################
class Macrophage
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

  # MACROPHAGE TYPES
  THP1 = 1
  PM = 2
  DM1ST = 3
  DMTERM = 4
  BLOOD_MONO = 5

  # An array of hash entries that specify the different types of
  # macrophages.
  MAC_TYPE={
    'THP1'        => THP1,
    'PM'          => PM,
    'DM 1st Tri'  => DM1ST,
    'DM term'     => DMTERM,
    'Blood Mono'  => BLOOD_MONO,
  }

  # TREATMENTS
  NONE = 1
  PGE2 = 2
  LTB4 = 3

  # A hash entries that specify treat choices
  TREATMENTS = {
    'None' => NONE,
    'PGE2' => PGE2,
    'LTB4' => LTB4,
  }

  # Dose measures
  Zero_uM = 1
  PointOne_uM = 2
  One_uM = 3
  Ten_uM = 4

  # Dosage hash enteries that specify dosage levels
  DOSAGE_OPTIONS = {
    '0 um'    => Zero_uM,
    '0.1 um'  => PointOne_uM,
    '1 um'    => One_uM,
    '10 um'   => Ten_uM
  }

  # Data types
  NUM_PER_THP1_CELL = 1
  NOMALIZED_PHAGO_ACTIVITY = 2

  # Data type array - hash entries for data type labels and values
  DATATYPES = {
    '# per THP1 cell'           => NUM_PER_THP1_CELL,
    'Normalized phago activity' => NOMALIZED_PHAGO_ACTIVITY,
  }


  ## ATTRIBUTES --------------------------------------------------------

  field :strain_name, type: String
  field :experiment_id, type: String
  field :macrophage_type, type: Integer
  field :treatment, type: Integer
  field :dose, type: Integer
  field :data, type: Float
  field :data_type, type: Integer
  field :notes, type: String

  ## VALIDATIONS -------------------------------------------------------

  validates_uniqueness_of :experiment_id
  validates_presence_of :experiment_id
  validates_presence_of :strain_name
  validates_presence_of :macrophage_type
  validates_presence_of :treatment
  validates_presence_of :dose
  validates_presence_of :data
  validates_presence_of :data_type
  validates_presence_of :user_id

  ## INDICES -----------------------------------------------------------

  index({strain_name: 1}, {unique: true, name: "strain_index" })
  index({experiment_id: 1}, {unique: true, name: "experiment_index" })
  index({strain_name: 1}, {unique: false, name: "strain_index"})
  index({macrophage_type: 1}, {unique: false, name: "macrophage_type_index"})
  index({treatment: 1}, {unique: false, name: "treatment_index"})

  ## PREDEFINED SCOPES -------------------------------------------------

  scope :by_strain, ->(strain){ where(strain_name: /#{strain}/i).order_by([[:strain_name, :asc]]) }
  scope :by_experiment, ->(eid){ where(experiment_id: /#{eid}/i).order_by([[:experiment_id, :asc]]) }
  scope :by_macrophage, ->(mid){ where(macrophage_type: mid).order_by([[:macrophage_type, :asc]]) }

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
  # The macrophage_type_str method will return the human readable form
  # of the macrophage type identifier.
  ######################################################################
  def macrophage_type_str
    return attribute_str(MAC_TYPE, macrophage_type)
  end

  ######################################################################
  # The treatment_str helper method returns the human readable string
  # that represents the treatment identifier.
  ######################################################################
  def treatment_str
    return attribute_str(TREATMENTS, treatment)
  end

  ######################################################################
  # The dosage_str helper method returns the human readable string
  # that represents the dosage identifier.
  ######################################################################
  def dosage_str
    return attribute_str(DOSAGE_OPTIONS, dose)
  end

  ######################################################################
  # The datatype_str helper method returns the human readable string
  # that represents the data type identifier.
  ######################################################################
  def datatype_str
    return attribute_str(DATATYPES, data_type)
  end

  #####################################################################
  # The to_csv class method converts the model contents to
  # CSV format. It takes one optional parameter.
  # * options - a hash of CSV generation options see Ruby CSV generate documentation
  ####################################################################
  def self.to_csv(options = {})

    CSV.generate(options) do |csv|
      column_header =  ["Experiment", "Strain", "Macrophage", "Treatment",
        "Dose", "Data Type", "Data", "Notes"]

      # Output column header
      csv << column_header

      # Create a new array for the row
      row = Array.new
      all.each do |mac|

        # Macrophage information
        row << mac.experiment_id
        row << mac.strain_name
        row << mac.macrophage_type_str
        row << mac.treatment_str
        row << mac.dosage_str
        row << mac.datatype_str
        row << mac.data
        row << mac.notes

        # Ouput the CSV ROW
        csv << row

        # Clear out the row for the next one
        row.clear

      end # all.each

    end # CSV

  end # def

end
