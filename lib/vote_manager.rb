class VoteManager
  include ActiveModel::Validations
  
  attr_accessor :first_name, :last_name, :birth_date, :vote
  
  validates :first_name, :last_name, presence: true
  validates :vote, inclusion: { in: [true, false] }
  validate  :birth_date_validation

  def initialize(params)
    prepare params
  end

  def publish!
	  self.validate!
    publish_vote
  end

  private

  def prepare(params)
  	@first_name = params[:first_name]
    @last_name = params[:last_name]
    @birth_date = params[:birth_date]
    @vote = params[:vote]
  end

  def publish_vote
  	WaterDrop::SyncProducer.call(json_record, topic: 'vote')
  end

  def json_record
    record = {
      first_name: @first_name,
      last_name: @last_name,
      birth_date: @birth_date,
      vote: @vote
    }.to_json
  end

  def birth_date_validation     
    errors.add(:birth_date, "is not valid") unless valid_birth_date?
  end

  def valid_birth_date?
    begin
      Date.parse(birth_date)
      true
    rescue ArgumentError
      false
    end
  end
end