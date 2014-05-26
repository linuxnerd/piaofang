module BoxofficesHelper

  # Usage:
  # render_table(@users,
  #   [
  #     { :name => 'id', :display_name => 'Id' },
  #     { :name => 'login', :display_name => 'Login' },
  #     { :name => 'first_name', :display_name => 'Name' },
  #     { :name => 'last_name', :display_name => 'LastName' },
  #     { :name => 'email', :display_name => 'Email'}
  #   ]
  # )
  def render_table(collection = {}, columns)
    thead = content_tag :thead do
     content_tag :tr do
      columns.collect {|column| concat content_tag(:th,column[:display_name])}.join().html_safe
     end
   end

   tbody = content_tag :tbody do
    collection.collect { |elem|
      content_tag :tr do
        columns.collect { |column|
            concat content_tag(:td, elem.attributes[column[:name]])
        }.to_s.html_safe
      end
    }.join().html_safe
   end

   content_tag :table, thead.concat(tbody), class: 'ui table segment'
  end

  def render_rating(rating)
    content_tag :div, class: 'ui heart rating', :'data-rating' => rating.split('.').first.to_i/2 do
      active_heart = (rating.split('.').first.to_i/2).times do
        concat content_tag(:i, '', class: 'icon active')
      end.to_s.html_safe

      empty_heart = (5-rating.split('.').first.to_i/2).times do
        concat content_tag(:i, '', class: 'icon')
      end.to_s.html_safe
    end
  end

end
