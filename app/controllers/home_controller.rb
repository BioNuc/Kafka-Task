class HomeController < ApplicationController
  def index
  	WaterDrop::SyncProducer.call('message', topic: 'testTopic')
  end
end