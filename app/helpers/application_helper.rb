module ApplicationHelper
  def page_title(page_title = '')
    base_title = '...次、どこ行く？'

    page_title.empty? ? base_title : page_title + ' | ' + base_title
  end
end
