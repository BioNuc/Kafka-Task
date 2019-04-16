class VoteManager
  include ActiveModel::Validations
  validate :record_validation

  def publish!(params)
	  @params = params
    self.validate!
    prepare params
	  publish_vote
  end

  private

  def record_validation 
    validate_name
    validate_birth_date
  end

  def validate_name
    if !@params[:first_name].blank?
      errors.add(:first_name, "can't be blank")
      raise ActiveModel::ValidationError.new(self)
    end
    if @params[:last_name].blank?
      errors.add(:last_name, "can't be blank")
      raise ActiveModel::ValidationError.new(self)
    end
  end

  def validate_birth_date
    y, m, d = @params[:birth_date].split '-'
    if !Date.valid_date? y.to_i, m.to_i, d.to_i
      errors.add(:birth_date, "is not valid")
      raise ActiveModel::ValidationError.new(self)
    end
  end

  def prepare(params)
  	@record = {
  	 first_name: params[:first_name],
  	 last_name: params[:last_name],
  	 birth_date: params[:birth_date],
  	 vote: params[:vote]
  	}
  	@record = @record.to_json
  end

  def publish_vote
  	WaterDrop::SyncProducer.call(@record, topic: 'vote')
  end
end