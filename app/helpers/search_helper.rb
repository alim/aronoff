module SearchHelper
  def tag_options_list
    tags = Macrophage.tags + ImmuneResponse.tags
    tag_list = []
    opts = options_for_select(tags.uniq.sort.each{|tag| tag_list << [tag, tag] })
    return opts
  end
end
