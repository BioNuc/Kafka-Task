class VoteManager
  include ActiveModel::Validations
  
  attr_reader :first_name, :last_name, :birth_date, :vote

  def initialize(params)
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    
    begin
      @birth_date = Date.parse(params[:birth_date])
    rescue
      @birth_date = nil
    end
    
    @vote = (params[:vote] == "1" ? true : false)
  end

  validates :first_name, :last_name, :birth_date, presence: true
  validates :vote, inclusion: { in: [true, false] }

  def publish!
    self.validate!
    publish_vote
  end

  private

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
end