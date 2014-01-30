module ApplicationHelper
  def list_by(selectors)
    selection_list = []
    selectors.each do |selector|
      selection_list.push([selector.name, selector.id])
    end
    selection_list
  end
end
