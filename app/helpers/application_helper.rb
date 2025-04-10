module ApplicationHelper

  def status_color(status)
    case status
    when 'completed' then 'bg-green-100 text-green-800'
    when 'pending' then 'bg-blue-100 text-blue-800'
    when 'cancelled' then 'bg-red-100 text-red-800'
    when 'shipped' then 'bg-purple-100 text-purple-800'
    else 'bg-gray-100 text-gray-800'
    end
  end
end
