class VoteManager
  include ActiveModel::Validations
  validate :record_validation

  def publish(params)
	prepare params
	publish_vote
  end

  private

  def record_validation 
  	
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
  	WaterDrop::SyncProducer.call(@record, topic: 'voteTopic')
  end
end