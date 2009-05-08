(setq global-abbrev-table (make-abbrev-table))

(require 'rails-lib)

(def-snips (global-abbrev-table)

;  ("frm"     "<fieldset>\n   <legend>$${Titel des Formulars}</legend>\n   <% form_for :$${entry}, :url => {:action => '$${add_comment}', :id => $${entry}} do |form| %>\n      <label for =\"$${comment}\">$${Kommentar}:<%= form.text_area :$${comment} %></label><br/>\n      <label for =\"$${author}\">$${Autor}:<%= form.text_field :$${feld2} %></label><br>\n      <%= submit_tag '$${Kommentar senden}', :class => 'submit' %>\n   <% end %>\n</fieldset>")

;  ("frm"     "<%= error_messages_for :$${item} %>\n<fieldset>\n   <legend>$${Titel des Formulars}</legend>\n   <% form_for ($${[:mutterklasse, }@$${item}$${]}) do |form| %>\n\n\n\n      <%= form.submit '$${Save}', :class => 'submit' %>\n   <% end %>\n</fieldset>" "default form")


;  ("frm" "<% error_handling_form_for(@$${model}, :title => t(\"$${title}\")) do |f| -%> \n  <%= f.error_messages %>\n\n  <%= f.submit t('general.forms.update'), :class => 'submit', :accesskey => 's', :title => 'Ctrl+s' %> \n<% end -%>\n\n"    "default form")
  ("frm" "
#form
  %h1 h1
  %h2 h2
  %p.quiet
    erklaerung
  
  - error_handling_form_for(@$${model}, :title => t(\".create_$${model}\")) do |f|
    = f.error_messages
    - f.fields_for :${{model}} do |p| 


    %div.submit
      = f.submit t('general.forms.save'), :class => 'submit', :accesskey => 's', :title => 'Ctrl+s'
"    "default form")


  ;("tb"      "      <label for =\"$${feldname}\">$${Beschriftung}:</label><%= form.text_field :$${feldname} %><br/>\n" "text box")
  ("tb"   "<%= f.text_field :$${field}, :hint => t('.$${field}_hint') %>"  "text box")

  ("unittest1"  "  def test_invalid_with_empty_attributes\n    $${item} = $${Class}.new\n    assert !$${item}.valid?\n    assert $${item}.errors.invalid?(:$${name})\n  end\n\n\n  def test_create\n      $${item} = $${Class}.new\n      $${item}.$${name} = $${value}\n      assert $${item}.save\n   end\n" "unit test empty invalid, create")

  ("k"      ":$${key} => '$${value}'")

; Textfeld mit Autocomplete
  ("acc" "   auto_complete_for :$${modelname}, :$${field}

  def auto_complete_for_$${modelname}_$${field}\n    value = params[:$${modelname}][:$${field}]
    $${Modelname}.find(:all, :conditions => ['lower($${field}) like ?',
                                       '%' + value.downcase + '%'])
    #render :partial => 'namen'
  end")

  ("acv" "<%=  text_field_with_auto_complete :$${modelname}, :$${field} %>")

; Sortable list element
; model
  ("sm" "#TODO: add field 'position' to table!\n  acts_as_list :scope => :$${parentclass}_id")
; controller
  ("sc" "  def order
    pos = 1
    list = 'list' + params[:id]
    params[list].each do |id|
      $${class} = $${Class}.find(id)
      $${class}.position = pos
      $${class}.save
      pos += 1
    end
    render :nothing => true
  end
  ")
;view
  ("sv" "<% list = 'list' + $${parentclass}.id.to_s %>
<ul id='<%= list %>'>
   <% for $${class} in $${parentclass}.$${class}s %>
      <li id='<%= list %>_<%= $${class}.id  %>'><%= h $${class}.$${field} %></li>
   <% end %>
</ul>

<%= sortable_element list ,
                 :url => {:action => 'order', :id => $${parentclass}} ,
                 :complete => visual_effect(:highlight,  list)
                 #oder :highlight, :puff, :squish, :fade
%>
  ")
  ("ak" ":accesskey => '$${s}', :title => 'Ctrl+$${s}'")


;unit-test
  ("utinv" "
  def test_invalid_with_empty_attributes
    $${unitname} = $${ClassName}.new
    assert !$${unitname}.valid?
    assert $${unitname}.errors.invalid?(:$${numericfield})
    assert $${unitname}.errors.invalid?(:$${field1})
    assert $${unitname}.errors.invalid?(:order_id)
    assert $${unitname}.errors.invalid?(:product_id)
  end")

  ("utcr" "# creation of default record
  def test_should_create_$${unitname}
    assert_difference $${ClassName}, :count do
      assert create_$${unitname}.valid?
    end
  end")

  ("utnum" "# test of numeric fields
  def test_should_require_$${numericfield}
    assert_no_difference $${ClassName}, :count do
      $${unitname} = create_$${unitname}(:$${numericfield} => nil)
      assert $${unitname}.errors.on(:$${numericfield})

      $${unitname} = create_$${unitname}(:$${numericfield} => -3)
      assert $${unitname}.errors.on(:$${numericfield})

      $${unitname} = create_$${unitname}(:$${numericfield} => 0)
      assert $${unitname}.errors.on(:$${numericfield})
    end
  end")

  ("utinv2" "# test valid / invald values for $${field1}
  def test_$${field1}
    ok = %w{  $${ok_values}  }
    bad = %w{ $${bad_values} }

    ok.each do |$${field1}|
      $${unitname} = create_$${unitname}(:$${field1} => $${field1})
      assert $${unitname}.valid?
      assert !$${unitname}.errors.invalid?(:$${field1}), \"should be valid #{$${field1}}\"
    end

    bad.each do |$${field1}|
      $${unitname} = create_$${unitname}(:$${field1} => $${field1})
      assert !$${unitname}.valid?
      assert $${unitname}.errors.invalid?(:$${field1}), \"should be invalid #{$${field1}}\"
    end
  end")

  ("ut" "#shortcuts:
         #utinv (invalid with empty attributes)
         #utinv2 (ok and bad values )
         #utcr (create default record)
         #utnum (check numeric values)
protected
  def create_$${unitname}(options = {})
    $${ClassName}.create({ :$${numericfield} => $${5},
                           :$${field1} => $${17.5}
                         }.merge(options))
  end
")
;ende unit-test

;RSPEC unit test
("utr" "  def valid_attributes
    {
      :$${field1} => '$${value1}'
    }
  end

  before(:each) do
    @$${class} = $${Class}.new(valid_attributes)
  end

  it \"should validate with exactly the specified attributes\" do
     @$${class}.should validate_with_exactly(valid_attributes)
   end
")

; functional tests
  ("ft" "

  def test_$${method2}
    o = $${klass}s('$${first}')
    get :$${method1}, {:id => $${o}.id}, {:$${user} => users(:$${role}).id}
    assert_response :success

    submit_form '/$${klass}/$${method2}' do |form|
      form.$${klass}.$${field1}= \"$${value1}\"
      form.$${klass}.$${field2}= \"$${value2}\"
    end

    #TODO asssert
    #assert_redirected_to :controller => '$${controller}'
    #assert_select \"ol li div.search-result-title\", :text => o.titel, :count => 1
    #assert assigns(:content).valid?  #@content
    #assert_flash :notice, '...'
    #assert_raise(ActiveRecord::RecordNotFound) { Content.find(o.id) }
    #assert session[:user]
    #assert_no_difference Content, :count do
    # try to delete record
    #end

  end

")

  ("ftinv" "  def test_should_require_$${feld}_on_create
    assert_no_difference $${Klass}, :count do
      create_$${class}(:$${feld} => nil)
      assert assigns(:$${class}).errors.on($${feld})
      assert_response :success
    end
  end

  protected
  def create_$${class}(options = {})
    post :create, :class => { :$${feld1} => '$${wert1}',  :$${feld2} => '$${wert2}' }.merge(options)
  end

")

)
(provide 'my-global-abbrev)
