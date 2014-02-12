########################################################################
# The SharedInstanceMethods module is used for storing methods that will be
# accross multiple Rails model classes. To use these methods, you will
# need to:
#
#    include SharedInstanceMethods
#
# in your model class definition
########################################################################
module SharedInstanceMethods

  ######################################################################
  # The attribute_str method is a utility instance method that is used
  # to print the human readable string associated with an attribute
  # value. It takes two parameters as follows:
  #
  # * ahash - is a hash that stores possible values for an attribute the key is assumed to be the label
  # * value - is the value of the attribute that is stored in the object.
  ######################################################################
  def attribute_str(ahash, value)
    str = 'Unknown'

    if ahash.present? & value.present?
      ahash.each do |label, hash_value|
        if hash_value == value
          str = label
          break
        end
      end
    end
    return str
  end

  ## The tag methods are Model helpers for adding tags to an Array
  ## based model attribute. It assumes that the attribute name is 'tags'
  ## and is of the type Array for Mongodb storage.

  ######################################################################
  # tag_list= will translate String based tag list that is separated by
  # commas into an array of tag strings. It will strip white spaces 
  # from the tag list string.
  ######################################################################
  def tag_list=(tag_string)
    self.tags = tag_string.gsub(/,\s+/, ',').split(',')
  end

  ######################################################################
  # The tag_list method is used for displaying the tag array as a string
  ######################################################################
  def tag_list
    self.tags.join(', ') if self.tags
  end

end
