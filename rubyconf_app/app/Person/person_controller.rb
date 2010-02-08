require 'rho/rhocontroller'

class PersonController < Rho::RhoController

  #GET /Person
  def index
    @people = Person.find(:all)
    render
  end

  # GET /Person/{1}
  def show
    @person = Person.find(@params['id'])
    if @person
      render :action => :show
    else
      redirect :action => :index
    end
  end

  # GET /Person/new
  def new
    @person = Person.new
    render :action => :new
  end

  # GET /Person/{1}/edit
  def edit
    @person = Person.find(@params['id'])
    if @person
      render :action => :edit
    else
      redirect :action => :index
    end
  end

  def map
    p "------------------------------------- map"
    @people = Person.find(:all)
    annotations = @people.map do |person|
      p "person=#{person.inspect}"
      result = {}
      unless person.latitude.nil? or person.latitude.empty?
        result[:latitude] = person.latitude
        result[:longitude] = person.longitude
      end
      result[:title] = person.name
      result[:subtitle] = person.twitter
      result[:street_address] = person.zip
      result[:url] = "/app/Person/#{person.object}/show"
      result
    end
    p "annotations=#{annotations}"
    MapView.create(
      :settings => {:map_type => "hybrid", :region => ["US"],
                    :zoom_enabled => true, :scroll_enabled => true, :shows_user_location => false},
      :annotations => annotations
    )
    redirect :action => :index
  end

  # POST /Person/create
  def create
    p "------------------------------------- create #{@params}"
    person_attrs = @params['person']
    if person_attrs['use_current_location'] == "on"
      person_attrs.delete('use_current_location')
      sleep(5) until GeoLocation.latitude != 0
      person_attrs['latitude'] = GeoLocation.latitude.to_s
      person_attrs['longitude'] = GeoLocation.longitude.to_s
    end
    @person = Person.new(person_attrs)
    @person.save
    redirect :action => :index
  end

  # POST /Person/{1}/update
  def update
    @person = Person.find(@params['id'])
    @person.update_attributes(@params['person']) if @person
    redirect :action => :index
  end

  # POST /Person/{1}/delete
  def delete
    @person = Person.find(@params['id'])
    @person.destroy if @person
    redirect :action => :index
  end
end
