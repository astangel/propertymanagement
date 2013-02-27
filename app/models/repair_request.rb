class RepairRequest < ActiveRecord::Base
  attr_accessible :open_date, :close_date, :request_details, :request_response, :submitter_ids, :responder_ids, :submitter, :responder

  belongs_to :submitter, :class_name => 'User', :foreign_key => 'submitter_id'
  belongs_to :responder, :class_name => 'User', :foreign_key => 'responder_id'
end
