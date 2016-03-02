class CancelledAppointment

  attr_accessor :doctor, :patient, :date_time

  def initialize(attributes={})
    @doctor = attributes[:doctor]
    @patient = attributes[:patient]
    @date_time = attributes[:date_time]
  end
end
